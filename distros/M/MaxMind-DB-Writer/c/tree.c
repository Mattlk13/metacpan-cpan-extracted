#include "tree.h"

#ifndef WIN32
#include <sys/mman.h>
#else
#include "windows_mman.h"
#endif

#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <netdb.h>
#include <stdbool.h>
#include <stdio.h>

#ifdef __GNUC__
#define UNUSED(x) UNUSED_##x __attribute__((__unused__))
#else
#define UNUSED(x) UNUSED_##x
#endif

/* This is also defined in MaxMind::DB::Common but we don't want to have to
 * fetch it every time we need it. */
#define DATA_SECTION_SEPARATOR_SIZE (16)

#define SHA1_KEY_LENGTH (27)

#define MERGE_KEY_SIZE (57)

typedef struct freeze_args_s {
    FILE *file;
    char *filename;
    HV *data_hash;
} freeze_args_s;

typedef struct thawed_network_s {
    MMDBW_network_s *network;
    MMDBW_record_s *record;
} thawed_network_s;

typedef struct encode_args_s {
    PerlIO *output_io;
    SV *root_data_type;
    SV *serializer;
    HV *data_pointer_cache;
} encode_args_s;

struct network {
    const char *const ipstr;
    const uint8_t prefix_length;
};

static void verify_ip(MMDBW_tree_s *tree, const char *ipstr);
static int128_t ip_string_to_integer(const char *ipstr, int family);
static int128_t ip_bytes_to_integer(uint8_t *bytes, int family);
static void
integer_to_ip_bytes(int tree_ip_version, uint128_t ip, uint8_t *bytes);
static void integer_to_ip_string(int tree_ip_version,
                                 uint128_t ip,
                                 char *dst,
                                 int dst_length);
static int prefix_length_for_largest_subnet(uint128_t start_ip,
                                            uint128_t end_ip,
                                            int family,
                                            uint128_t *reverse_mask);
static const char *
store_data_in_tree(MMDBW_tree_s *tree, const char *const key, SV *data_sv);
static const char *increment_data_reference_count(MMDBW_tree_s *tree,
                                                  const char *const key);
static void
set_stored_data_in_tree(MMDBW_tree_s *tree, const char *const key, SV *data_sv);
static void decrement_data_reference_count(MMDBW_tree_s *tree,
                                           const char *const key);
static MMDBW_network_s resolve_network(MMDBW_tree_s *tree,
                                       const char *const ipstr,
                                       uint8_t prefix_length);
static MMDBW_status
resolve_ip(int tree_ip_version, const char *const ipstr, uint8_t *bytes);
static void free_network(MMDBW_network_s *network);
static void alias_ipv4_networks(MMDBW_tree_s *tree);
static MMDBW_status insert_reserved_networks_as_fixed_empty(MMDBW_tree_s *tree);
static MMDBW_status
insert_networks_as_fixed_empty(MMDBW_tree_s *tree,
                               struct network const *const networks,
                               const size_t num_networks);
static MMDBW_status
insert_record_for_network(MMDBW_tree_s *tree,
                          MMDBW_network_s *network,
                          MMDBW_record_s *new_record,
                          MMDBW_merge_strategy merge_strategy,
                          bool is_internal_insert);
static MMDBW_status
insert_record_into_next_node(MMDBW_tree_s *tree,
                             MMDBW_record_s *current_record,
                             MMDBW_network_s *network,
                             int current_bit,
                             MMDBW_record_s *new_record,
                             MMDBW_merge_strategy merge_strategy,
                             bool is_internal_insert);
static MMDBW_status
insert_record_into_current_record(MMDBW_tree_s *tree,
                                  MMDBW_record_s *current_record,
                                  MMDBW_network_s *network,
                                  MMDBW_record_s *new_record,
                                  MMDBW_merge_strategy merge_strategy);
static const char *maybe_merge_records(MMDBW_tree_s *tree,
                                       MMDBW_network_s *network,
                                       MMDBW_record_s *new_record,
                                       MMDBW_record_s *record_to_set,
                                       MMDBW_merge_strategy merge_strategy);
static int network_bit_value(MMDBW_network_s *network, uint8_t current_bit);
static int tree_depth0(MMDBW_tree_s *tree);
static SV *merge_hashes(MMDBW_tree_s *tree,
                        SV *from,
                        SV *into,
                        MMDBW_merge_strategy merge_strategy);
static void merge_new_from_hash_into_hash(MMDBW_tree_s *tree,
                                          HV *from,
                                          HV *to,
                                          MMDBW_merge_strategy merge_strategy);
static SV *merge_values(MMDBW_tree_s *tree,
                        SV *from,
                        SV *into,
                        MMDBW_merge_strategy merge_strategy);
static SV *merge_arrays(MMDBW_tree_s *tree,
                        SV *from,
                        SV *into,
                        MMDBW_merge_strategy merge_strategy);
static MMDBW_status find_record_for_network(MMDBW_tree_s *tree,
                                            MMDBW_network_s *network,
                                            MMDBW_record_s **record);
static MMDBW_node_s *new_node_from_record(MMDBW_tree_s *tree,
                                          MMDBW_record_s *record);
static MMDBW_status free_node_and_subnodes(MMDBW_tree_s *tree,
                                           MMDBW_node_s *node,
                                           bool remove_alias_and_fixed_nodes);
static MMDBW_status free_record_value(MMDBW_tree_s *tree,
                                      MMDBW_record_s *record,
                                      bool remove_alias_and_fixed_nodes);
static void assign_node_number(MMDBW_tree_s *tree,
                               MMDBW_node_s *node,
                               uint128_t UNUSED(network),
                               uint8_t UNUSED(depth),
                               void *UNUSED(args));
static void freeze_search_tree(MMDBW_tree_s *tree, freeze_args_s *args);
static void freeze_node(MMDBW_tree_s *tree,
                        MMDBW_node_s *node,
                        uint128_t network,
                        uint8_t depth,
                        void *void_args);
static void freeze_data_record(MMDBW_tree_s *UNUSED(tree),
                               uint128_t network,
                               uint8_t depth,
                               const char *key,
                               freeze_args_s *args);
static void freeze_to_file(freeze_args_s *args, void *data, size_t size);
static void freeze_data_to_file(freeze_args_s *args, MMDBW_tree_s *tree);
static SV *freeze_hash(HV *hash);
static uint8_t thaw_uint8(uint8_t **buffer);
static thawed_network_s *thaw_network(MMDBW_tree_s *tree, uint8_t **buffer);
static uint8_t *thaw_bytes(uint8_t **buffer, size_t size);
static uint128_t thaw_uint128(uint8_t **buffer);
static STRLEN thaw_strlen(uint8_t **buffer);
static const char *thaw_data_key(uint8_t **buffer);
static HV *thaw_data_hash(SV *data_to_decode);
static void encode_node(MMDBW_tree_s *tree,
                        MMDBW_node_s *node,
                        uint128_t UNUSED(network),
                        uint8_t UNUSED(depth),
                        void *void_args);
static void
check_record_sanity(MMDBW_node_s *node, MMDBW_record_s *record, char *side);
static uint32_t record_value_as_number(MMDBW_tree_s *tree,
                                       MMDBW_record_s *record,
                                       encode_args_s *args);
static void iterate_tree(MMDBW_tree_s *tree,
                         MMDBW_record_s *record,
                         uint128_t network,
                         const uint8_t depth,
                         bool depth_first,
                         void *args,
                         MMDBW_iterator_callback callback);
static SV *key_for_data(SV *data);
static const char *merge_cache_lookup(MMDBW_tree_s *tree,
                                      char *merge_cache_key);
static void store_in_merge_cache(MMDBW_tree_s *tree,
                                 char *merge_cache_key,
                                 const char *const new_key);
static void *checked_malloc(size_t size);
static void
checked_fwrite(FILE *file, char *filename, void *buffer, size_t count);
static void check_perlio_result(SSize_t result, SSize_t expected, char *op);
static char *status_error_message(MMDBW_status status);
static const char *record_type_name(MMDBW_record_type type);

// Create a new tree.
//
// For a description of `alias_ipv6' and `remove_reserved_networks', refer to
// the MaxMind::DB::Writer::Tree documentation about these options.
MMDBW_tree_s *new_tree(const uint8_t ip_version,
                       uint8_t record_size,
                       MMDBW_merge_strategy merge_strategy,
                       const bool alias_ipv6,
                       const bool remove_reserved_networks) {
    if (merge_strategy == MMDBW_MERGE_STRATEGY_UNKNOWN) {
        croak("Unknown merge_strategy encountered");
    }
    if (ip_version != 4 && ip_version != 6) {
        croak("Unexpected IP version of %u", ip_version);
    }
    if (record_size != 24 && record_size != 28 && record_size != 32) {
        croak("Only record sizes of 24, 28, and 32 are supported. Received %u.",
              record_size);
    }

    MMDBW_tree_s *tree = checked_malloc(sizeof(MMDBW_tree_s));
    tree->ip_version = ip_version;

    tree->record_size = record_size;
    tree->merge_strategy = merge_strategy;
    tree->merge_cache = NULL;
    tree->data_table = NULL;
    tree->root_record = (MMDBW_record_s){
        .type = MMDBW_RECORD_TYPE_EMPTY,
    };
    tree->node_count = 0;

    if (alias_ipv6) {
        alias_ipv4_networks(tree);
    }

    if (remove_reserved_networks) {
        MMDBW_status const status =
            insert_reserved_networks_as_fixed_empty(tree);
        if (status != MMDBW_SUCCESS) {
            free_tree(tree);
            croak("Error inserting reserved networks: %s",
                  status_error_message(status));
        }
    }

    return tree;
}

void insert_network(MMDBW_tree_s *tree,
                    const char *ipstr,
                    const uint8_t prefix_length,
                    SV *key_sv,
                    SV *data,
                    MMDBW_merge_strategy merge_strategy) {
    verify_ip(tree, ipstr);

    MMDBW_network_s network = resolve_network(tree, ipstr, prefix_length);

    const char *const key =
        store_data_in_tree(tree, SvPVbyte_nolen(key_sv), data);
    MMDBW_record_s new_record = {.type = MMDBW_RECORD_TYPE_DATA,
                                 .value = {.key = key}};

    MMDBW_status status = insert_record_for_network(
        tree, &network, &new_record, merge_strategy, false);

    // The data's ref count gets incremented by the insert each time it is
    // inserted. As such, we need to decrement it here.
    decrement_data_reference_count(tree, key);
    free_network(&network);

    if (MMDBW_SUCCESS != status) {
        croak("%s (when inserting %s/%" PRIu8 ")",
              status_error_message(status),
              ipstr,
              prefix_length);
    }
}

static void verify_ip(MMDBW_tree_s *tree, const char *ipstr) {
    if (tree->ip_version == 4 && strchr(ipstr, ':')) {
        croak("You cannot insert an IPv6 address (%s) into an IPv4 tree.",
              ipstr);
    }
}

void insert_range(MMDBW_tree_s *tree,
                  const char *start_ipstr,
                  const char *end_ipstr,
                  SV *key_sv,
                  SV *data_sv,
                  MMDBW_merge_strategy merge_strategy) {
    verify_ip(tree, start_ipstr);
    verify_ip(tree, end_ipstr);

    uint128_t start_ip = ip_string_to_integer(start_ipstr, tree->ip_version);
    uint128_t end_ip = ip_string_to_integer(end_ipstr, tree->ip_version);

    if (end_ip < start_ip) {
        croak("First IP (%s) in range comes before last IP (%s)",
              start_ipstr,
              end_ipstr);
    }

    const char *const key =
        store_data_in_tree(tree, SvPVbyte_nolen(key_sv), data_sv);

    uint8_t bytes[tree->ip_version == 6 ? 16 : 4];

    MMDBW_status status = MMDBW_SUCCESS;

    // Eventually we could change the code to walk the tree and break up the
    // range at the same time, saving some unnecessary computation. However,
    // that would require more significant refactoring of the insertion and
    // merging code.
    while (start_ip <= end_ip) {
        uint128_t reverse_mask;
        int prefix_length = prefix_length_for_largest_subnet(
            start_ip, end_ip, tree->ip_version, &reverse_mask);

        integer_to_ip_bytes(tree->ip_version, start_ip, bytes);

        MMDBW_network_s network = {
            .bytes = bytes,
            .prefix_length = prefix_length,
        };

        MMDBW_record_s new_record = {.type = MMDBW_RECORD_TYPE_DATA,
                                     .value = {.key = key}};

        status = insert_record_for_network(
            tree, &network, &new_record, merge_strategy, false);

        if (MMDBW_SUCCESS != status) {
            break;
        }

        start_ip = (start_ip | reverse_mask) + 1;

        // The +1 caused an overflow and we are done.
        if (start_ip == 0) {
            break;
        }
    }
    // store_data_in_tree starts at a reference count of 1, so we need to
    // decrement in order to account for that.
    decrement_data_reference_count(tree, key);

    if (MMDBW_SUCCESS != status) {
        croak("%s (when inserting %s - %s)",
              status_error_message(status),
              start_ipstr,
              end_ipstr);
    }
}

static int128_t ip_string_to_integer(const char *ipstr, int family) {
    uint8_t bytes[family == 6 ? 16 : 4];
    if (resolve_ip(family, ipstr, bytes) != MMDBW_SUCCESS) {
        croak("Invalid IP address: %s", ipstr);
    }
    return ip_bytes_to_integer(bytes, family);
}

static int128_t ip_bytes_to_integer(uint8_t *bytes, int family) {
    int length = family == 6 ? 16 : 4;

    int128_t ipint = 0;
    for (int i = 0; i < length; i++) {
        ipint = (ipint << 8) | bytes[i];
    }
    return ipint;
}

static void
integer_to_ip_bytes(int tree_ip_version, uint128_t ip, uint8_t *bytes) {
    int bytes_length = tree_ip_version == 6 ? 16 : 4;
    for (int i = 1; i <= bytes_length; i++) {
        bytes[bytes_length - i] = 0xFF & ip;
        ip >>= 8;
    }
}

static void integer_to_ip_string(int tree_ip_version,
                                 uint128_t ip,
                                 char *dst,
                                 int dst_length) {
    uint8_t bytes[tree_ip_version == 6 ? 16 : 4];
    integer_to_ip_bytes(tree_ip_version, ip, bytes);

    if (NULL == inet_ntop(tree_ip_version == 6 ? AF_INET6 : AF_INET,
                          bytes,
                          dst,
                          dst_length)) {
        croak("Error converting IP integer to string");
    }
}

static int prefix_length_for_largest_subnet(uint128_t start_ip,
                                            uint128_t end_ip,
                                            int family,
                                            uint128_t *reverse_mask) {

    if (start_ip > end_ip) {
        croak("Start IP of the range must be less than or equal to end IP");
    }

    int prefix_length = family == 6 ? 128 : 32;
    *reverse_mask = 1;

    while (
        // First IP of the subnet must be the start IP
        (start_ip & ~*reverse_mask) == start_ip
        // the last IP of the subnet must be <= the end IP
        && (start_ip | *reverse_mask) <= end_ip
        // stop if we have all IPs (shouldn't be required, but safety measure)
        && prefix_length > 0) {
        prefix_length--;
        *reverse_mask = (*reverse_mask << 1) | 1;
    }

    // We overshoot by one shift
    *reverse_mask >>= 1;

    return prefix_length;
}

void remove_network(MMDBW_tree_s *tree,
                    const char *ipstr,
                    const uint8_t prefix_length) {
    verify_ip(tree, ipstr);

    MMDBW_network_s network = resolve_network(tree, ipstr, prefix_length);

    MMDBW_record_s new_record = {.type = MMDBW_RECORD_TYPE_EMPTY};

    MMDBW_status status = insert_record_for_network(
        tree, &network, &new_record, MMDBW_MERGE_STRATEGY_NONE, false);

    free_network(&network);
    if (status != MMDBW_SUCCESS) {
        croak(status_error_message(status));
    }
}

static const char *
store_data_in_tree(MMDBW_tree_s *tree, const char *const key, SV *data_sv) {
    const char *const new_key = increment_data_reference_count(tree, key);
    set_stored_data_in_tree(tree, key, data_sv);

    return new_key;
}

static const char *increment_data_reference_count(MMDBW_tree_s *tree,
                                                  const char *const key) {
    MMDBW_data_hash_s *data = NULL;
    HASH_FIND(hh, tree->data_table, key, SHA1_KEY_LENGTH, data);

    /* We allow this possibility as we need to create the record separately
       from updating the data when thawing */
    if (NULL == data) {
        data = checked_malloc(sizeof(MMDBW_data_hash_s));
        data->reference_count = 0;

        data->data_sv = NULL;

        data->key = checked_malloc(SHA1_KEY_LENGTH + 1);
        strcpy((char *)data->key, key);

        HASH_ADD_KEYPTR(hh, tree->data_table, data->key, SHA1_KEY_LENGTH, data);
    }
    data->reference_count++;

    return data->key;
}

static void set_stored_data_in_tree(MMDBW_tree_s *tree,
                                    const char *const key,
                                    SV *data_sv) {
    MMDBW_data_hash_s *data = NULL;
    HASH_FIND(hh, tree->data_table, key, SHA1_KEY_LENGTH, data);

    if (NULL == data) {
        croak("Attempt to set unknown data record in tree");
    }

    if (NULL != data->data_sv) {
        return;
    }

    SvREFCNT_inc_simple_void_NN(data_sv);
    data->data_sv = data_sv;
}

static void decrement_data_reference_count(MMDBW_tree_s *tree,
                                           const char *const key) {
    MMDBW_data_hash_s *data = NULL;
    HASH_FIND(hh, tree->data_table, key, SHA1_KEY_LENGTH, data);

    if (NULL == data) {
        croak("Attempt to remove data that does not exist from tree");
    }

    data->reference_count--;
    if (0 == data->reference_count) {
        HASH_DEL(tree->data_table, data);
        SvREFCNT_dec(data->data_sv);
        free((char *)data->key);
        free(data);
    }
}

static MMDBW_network_s resolve_network(MMDBW_tree_s *tree,
                                       const char *const ipstr,
                                       uint8_t prefix_length) {
    uint8_t *bytes = checked_malloc(tree->ip_version == 6 ? 16 : 4);

    if (resolve_ip(tree->ip_version, ipstr, bytes) != MMDBW_SUCCESS) {
        free(bytes);
        croak("Invalid IP address: %s", ipstr);
    }

    if (NULL == strchr(ipstr, ':')) {
        // IPv4
        if (prefix_length > 32) {
            free(bytes);
            croak("Prefix length greater than 32 on an IPv4 network (%s/%d)",
                  ipstr,
                  prefix_length);
        }
        if (tree->ip_version == 6) {
            // Inserting IPv4 network into an IPv6 tree
            prefix_length += 96;
        }
    } else if (prefix_length > 128) {
        free(bytes);
        croak("Prefix length greater than 128 on an IPv6 network (%s/%d)",
              ipstr,
              prefix_length);
    }

    MMDBW_network_s network = {
        .bytes = bytes,
        .prefix_length = prefix_length,
    };

    return network;
}

static MMDBW_status
resolve_ip(int tree_ip_version, const char *const ipstr, uint8_t *bytes) {
    bool is_ipv4_address = NULL == strchr(ipstr, ':');
    int family = is_ipv4_address ? AF_INET : AF_INET6;
    if (tree_ip_version == 6 && is_ipv4_address) {
        // We are inserting/looking up an IPv4 address in an IPv6 tree.
        // The canonical location for this in our database is ::a.b.c.d.
        // To get this address, we zero out the first 12 bytes of bytes
        // and then put the IPv4 address in the remaining 4. The reason to
        // not use getaddrinfo with AI_V4MAPPED is that it gives us
        // ::FFFF:a.b.c.d and AI_V4MAPPED doesn't work on all platforms.
        // See GitHub #7 and #51.
        memset(bytes, 0, 12);
        bytes += 12;
    }
    if (!inet_pton(family, ipstr, bytes)) {
        return MMDBW_RESOLVING_IP_ERROR;
    }
    return MMDBW_SUCCESS;
}

static void free_network(MMDBW_network_s *network) {
    free((char *)network->bytes);
}

static struct network ipv4_aliases[] = {
    {
        .ipstr = "::ffff:0:0",
        .prefix_length = 96,
    },
    {.ipstr = "2001::", .prefix_length = 32},
    {.ipstr = "2002::", .prefix_length = 16}};

static void alias_ipv4_networks(MMDBW_tree_s *tree) {
    if (tree->ip_version == 4) {
        return;
    }

    MMDBW_network_s ipv4_root_network = resolve_network(tree, "::0.0.0.0", 96);
    MMDBW_node_s *ipv4_root_node = new_node();
    MMDBW_record_s ipv4_root_record = {
        .type = MMDBW_RECORD_TYPE_FIXED_NODE,
        .value.node = ipv4_root_node,
    };

    MMDBW_status status = insert_record_for_network(tree,
                                                    &ipv4_root_network,
                                                    &ipv4_root_record,
                                                    MMDBW_MERGE_STRATEGY_NONE,
                                                    true);

    free_network(&ipv4_root_network);

    if (status != MMDBW_SUCCESS) {
        croak("Unable to create IPv4 root node when setting up aliases: %s",
              status_error_message(status));
    }

    for (size_t i = 0; i < sizeof(ipv4_aliases) / sizeof(struct network); i++) {
        MMDBW_network_s alias_network = resolve_network(
            tree, ipv4_aliases[i].ipstr, ipv4_aliases[i].prefix_length);

        MMDBW_record_s record_for_alias = {
            .type = MMDBW_RECORD_TYPE_ALIAS,
            .value.node = ipv4_root_node,
        };

        MMDBW_status status =
            insert_record_for_network(tree,
                                      &alias_network,
                                      &record_for_alias,
                                      MMDBW_MERGE_STRATEGY_NONE,
                                      true);

        free_network(&alias_network);

        if (MMDBW_SUCCESS != status) {
            croak("Unexpected error when searching for last node for alias: %s",
                  status_error_message(status));
        }
    }
}

// https://www.iana.org/assignments/iana-ipv4-special-registry/iana-ipv4-special-registry.xhtml
static struct network reserved_networks_ipv4[] = {
    {.ipstr = "0.0.0.0", .prefix_length = 8},
    {.ipstr = "10.0.0.0", .prefix_length = 8},
    {.ipstr = "100.64.0.0", .prefix_length = 10},
    {.ipstr = "127.0.0.0", .prefix_length = 8},
    {.ipstr = "169.254.0.0", .prefix_length = 16},
    {.ipstr = "172.16.0.0", .prefix_length = 12},
    // This is an odd case. 192.0.0.0/24 is reserved, but there is a note that
    // says "Not useable unless by virtue of a more specific reservation". As
    // such, since 192.0.0.0/29 was more recently reserved, it's possible the
    // intention is that the rest is not reserved any longer. I'm not too clear
    // on this, but I believe that is the rationale, so I choose to leave it.
    {.ipstr = "192.0.0.0", .prefix_length = 29},
    // TODO(wstorey@maxmind.com): 192.168.0.8/32
    // TODO(wstorey@maxmind.com): 192.168.0.9/32
    // TODO(wstorey@maxmind.com): 192.168.0.10/32
    // TODO(wstorey@maxmind.com): 192.168.0.170/32
    // TODO(wstorey@maxmind.com): 192.168.0.171/32
    {.ipstr = "192.0.2.0", .prefix_length = 24},
    // 192.31.196.0/24 is routable I believe
    // TODO(wstorey@maxmnd.com): 192.52.193.0/24
    // TODO(wstorey@maxmind.com): Looks like 192.88.99.0/24 may no longer be
    // reserved?
    {.ipstr = "192.88.99.0", .prefix_length = 24},
    {.ipstr = "192.168.0.0", .prefix_length = 16},
    // 192.175.48.0/24 is routable I believe
    {.ipstr = "198.18.0.0", .prefix_length = 15},
    {.ipstr = "198.51.100.0", .prefix_length = 24},
    {.ipstr = "203.0.113.0", .prefix_length = 24},
    // The above IANA page doesn't list 224.0.0.0/4, but at least some parts
    // are listed in https://tools.ietf.org/html/rfc5771
    {.ipstr = "224.0.0.0", .prefix_length = 4},
    {.ipstr = "240.0.0.0", .prefix_length = 4},
    // 255.255.255.255/32 gets brought in by 240.0.0.0/4.
};

// https://www.iana.org/assignments/iana-ipv6-special-registry/iana-ipv6-special-registry.xhtml
static struct network reserved_networks_ipv6[] = {
    // ::/128 and ::1/128 are reserved under IPv6 but these are already
    // covered under 0.0.0.0/8.
    //
    // ::ffff:0:0/96 - IPv4 mapped addresses. We treat it specially with the
    // `alias_ipv6_to_ipv4' option.
    //
    // 64:ff9b::/96 - well known prefix mapping, covered by alias_ipv6_to_ipv4
    //
    // TODO(wstorey@maxmind.com): 64:ff9b:1::/48 should be in
    // alias_ipv6_to_ipv4?

    {.ipstr = "100::", .prefix_length = 64},

    // 2001::/23 is reserved. We include all of it here other than 2001::/32
    // as it is Teredo which is globally routable.
    {.ipstr = "2001:1::", .prefix_length = 32},
    {.ipstr = "2001:2::", .prefix_length = 31},
    {.ipstr = "2001:4::", .prefix_length = 30},
    {.ipstr = "2001:8::", .prefix_length = 29},
    {.ipstr = "2001:10::", .prefix_length = 28},
    {.ipstr = "2001:20::", .prefix_length = 27},
    {.ipstr = "2001:40::", .prefix_length = 26},
    {.ipstr = "2001:80::", .prefix_length = 25},
    {.ipstr = "2001:100::", .prefix_length = 24},

    {.ipstr = "2001:db8::", .prefix_length = 32},
    // 2002::/16 - 6to4, part of alias_ipv6_to_ipv4
    // 2620:4f:8000::/48 is routable I believe
    {.ipstr = "fc00::", .prefix_length = 7},
    {.ipstr = "fe80::", .prefix_length = 10},
    // Multicast
    {.ipstr = "ff00::", .prefix_length = 8},
};

// Insert a FIXED_EMPTY record for all private and reserved networks.
//
// This is to avoid the case where we might otherwise accidentally add
// information about such networks.
static MMDBW_status
insert_reserved_networks_as_fixed_empty(MMDBW_tree_s *tree) {
    MMDBW_status const status = insert_networks_as_fixed_empty(
        tree,
        reserved_networks_ipv4,
        sizeof(reserved_networks_ipv4) / sizeof(struct network));
    if (status != MMDBW_SUCCESS) {
        return status;
    }

    if (tree->ip_version == 6) {
        MMDBW_status const status = insert_networks_as_fixed_empty(
            tree,
            reserved_networks_ipv6,
            sizeof(reserved_networks_ipv6) / sizeof(struct network));
        if (status != MMDBW_SUCCESS) {
            return status;
        }
    }

    return MMDBW_SUCCESS;
}

// Insert a FIXED_EMPTY record for each network.
static MMDBW_status
insert_networks_as_fixed_empty(MMDBW_tree_s *tree,
                               struct network const *const networks,
                               const size_t num_networks) {
    for (size_t i = 0; i < num_networks; i++) {
        MMDBW_network_s resolved_network =
            resolve_network(tree, networks[i].ipstr, networks[i].prefix_length);

        MMDBW_record_s record = {
            .type = MMDBW_RECORD_TYPE_FIXED_EMPTY,
        };

        MMDBW_status const status = insert_record_for_network(
            tree, &resolved_network, &record, MMDBW_MERGE_STRATEGY_NONE, true);

        free_network(&resolved_network);

        if (status != MMDBW_SUCCESS) {
            return status;
        }
    }

    return MMDBW_SUCCESS;
}

static MMDBW_status
insert_record_for_network(MMDBW_tree_s *tree,
                          MMDBW_network_s *network,
                          MMDBW_record_s *new_record,
                          MMDBW_merge_strategy merge_strategy,
                          bool is_internal_insert) {
    if (merge_strategy == MMDBW_MERGE_STRATEGY_UNKNOWN) {
        merge_strategy = tree->merge_strategy;
    }

    return insert_record_into_next_node(tree,
                                        &(tree->root_record),
                                        network,
                                        0,
                                        new_record,
                                        merge_strategy,
                                        is_internal_insert);
}

static MMDBW_status
insert_record_into_next_node(MMDBW_tree_s *tree,
                             MMDBW_record_s *current_record,
                             MMDBW_network_s *network,
                             int current_bit,
                             MMDBW_record_s *new_record,
                             MMDBW_merge_strategy merge_strategy,
                             bool is_internal_insert) {
    // We've reached the record where the network belongs. Depending on the
    // type of record it is, we insert right here.
    if (current_bit >= network->prefix_length &&
        (current_record->type == MMDBW_RECORD_TYPE_EMPTY ||
         current_record->type == MMDBW_RECORD_TYPE_DATA ||
         (current_record->type == MMDBW_RECORD_TYPE_NODE &&
          merge_strategy == MMDBW_MERGE_STRATEGY_NONE))) {
        return insert_record_into_current_record(
            tree, current_record, network, new_record, merge_strategy);
    }

    if (current_bit == network->prefix_length &&
        current_record->type == MMDBW_RECORD_TYPE_FIXED_NODE &&
        new_record->type == MMDBW_RECORD_TYPE_FIXED_NODE) {
        // We could potentially make this work, but it's tricky. One of the
        // purposes of fixed nodes is for alias nodes to point at them.
        // Returning success here without doing anything is not what we want to
        // do: We should be setting the node value to what is in the new record
        // since it may be setting up alias nodes pointing at it. Changing the
        // current node value is not an option either: Aliases may already be
        // pointing to it.
        //
        // If we don't have this case, we'll continue to descend the tree,
        // inserting the new record's fixed node in potentially multiple
        // locations. If that happens, we end up freeing the node multiple
        // times when destroying the tree.
        //
        // Consider the case where we previously inserted fixed nodes to a
        // greater depth than we are right now. Because we'd continue to
        // descend the tree, we'd insert this new fixed node record at
        // potentially multiple spots in the tree, at each point we encounter
        // an EMPTY, DATA, or NODE record (the conditions where we can enter
        // insert_record_into_current_record()). The stopping condition would
        // not be correct.
        return MMDBW_FIXED_NODE_OVERWRITE_ATTEMPT_ERROR;
    }

    // Figure out the next node.
    MMDBW_node_s *next_node = NULL;
    switch (current_record->type) {
        case MMDBW_RECORD_TYPE_EMPTY:
        case MMDBW_RECORD_TYPE_DATA: {
            // In this case we create a new node to point to. We make the new
            // nodes left and right identical to us.
            next_node = new_node_from_record(tree, current_record);
            current_record->value.node = next_node;
            current_record->type = MMDBW_RECORD_TYPE_NODE;
            break;
        }
        case MMDBW_RECORD_TYPE_FIXED_EMPTY:
            // We're a) trying to overwrite a fixed empty network, b) trying to
            // insert a network containing a fixed empty network, or c) trying
            // to insert inside a fixed empty network. (You can see these 3
            // cases handled separately in the ALIAS case.) We ignore the insert
            // with the assumption that it was not intended. e.g., you probably
            // didn't mean to insert data about a reserved network. Doing so
            // makes working with dirty data easier. Note this may change to be
            // more strict and return an error in the future.
            return MMDBW_SUCCESS;
            break;
        case MMDBW_RECORD_TYPE_ALIAS: {
            // The insert is trying to overwrite an aliased network. We do not
            // allow this.
            if (current_bit == network->prefix_length) {
                return MMDBW_ALIAS_OVERWRITE_ATTEMPT_ERROR;
            }

            // We don't follow aliases when inserting a network that contains
            // an aliased network within it.
            if (current_bit > network->prefix_length) {
                // We return success to silently ignore when we try to insert
                // here. If we raise an error, it makes working with dirty data
                // more difficult. We assume such inserts were not intended and
                // can be safely skipped.
                return MMDBW_SUCCESS;
            }
            // current_bit < network->prefix_length. This means we contain the
            // new network already as ALIAS. Inserting the network is not valid
            // because of that.
            return MMDBW_INSERT_INTO_ALIAS_NODE_ERROR;
            break;
        }
        case MMDBW_RECORD_TYPE_FIXED_NODE:
        case MMDBW_RECORD_TYPE_NODE: {
            // We're a node already.
            next_node = current_record->value.node;
            break;
        }
    }

    // If we are inserting an alias, a fixed node, or a fixed empty record, we
    // make all of the nodes down to that record fixed nodes. This makes it
    // easier to not accidentally delete or modify them.
    if (new_record->type == MMDBW_RECORD_TYPE_ALIAS ||
        new_record->type == MMDBW_RECORD_TYPE_FIXED_NODE ||
        new_record->type == MMDBW_RECORD_TYPE_FIXED_EMPTY) {
        current_record->type = MMDBW_RECORD_TYPE_FIXED_NODE;
    }

    bool next_is_right = network_bit_value(network, current_bit);

    // if we are beyond the prefix length, both records are within the
    // network we are inserting.
    bool insert_into_both = current_bit >= network->prefix_length;

    if (next_is_right || insert_into_both) {
        MMDBW_status status =
            insert_record_into_next_node(tree,
                                         &(next_node->right_record),
                                         network,
                                         current_bit + 1,
                                         new_record,
                                         merge_strategy,
                                         is_internal_insert);
        if (status != MMDBW_SUCCESS) {
            return status;
        }
    }

    if (!next_is_right || insert_into_both) {
        MMDBW_status status =
            insert_record_into_next_node(tree,
                                         &(next_node->left_record),
                                         network,
                                         current_bit + 1,
                                         new_record,
                                         merge_strategy,
                                         is_internal_insert);
        if (status != MMDBW_SUCCESS) {
            return status;
        }
    }

    // We inserted the new record into the right and/or left record of the next
    // node. We now need to trim the tree upwards by merging identical records.
    // Basically what we do here is take care of the case where the record
    // we're at points at another node, and the records in that node are both
    // the same. In that case, we delete the node we point at and take its
    // value on ourselves.

    if (next_node->left_record.type == next_node->right_record.type &&
        // We don't allow merging into aliases or fixed nodes
        current_record->type == MMDBW_RECORD_TYPE_NODE) {
        switch (next_node->left_record.type) {
            case MMDBW_RECORD_TYPE_EMPTY: {
                MMDBW_status status =
                    free_node_and_subnodes(tree, next_node, false);
                if (status != MMDBW_SUCCESS) {
                    return MMDBW_SUCCESS;
                }
                current_record->type = MMDBW_RECORD_TYPE_EMPTY;
                break;
            }
            case MMDBW_RECORD_TYPE_DATA: {
                // If the two keys are the same, the records can be merged.
                // Otherwise, break.
                if (strcmp(next_node->left_record.value.key,
                           next_node->right_record.value.key)) {
                    break;
                }
                const char *key = increment_data_reference_count(
                    tree, next_node->left_record.value.key);
                MMDBW_status status =
                    free_node_and_subnodes(tree, next_node, false);
                if (status != MMDBW_SUCCESS) {
                    return MMDBW_SUCCESS;
                }
                current_record->type = MMDBW_RECORD_TYPE_DATA;
                current_record->value.key = key;
                break;
            }
            case MMDBW_RECORD_TYPE_ALIAS:
            case MMDBW_RECORD_TYPE_FIXED_NODE:
            case MMDBW_RECORD_TYPE_FIXED_EMPTY:
            case MMDBW_RECORD_TYPE_NODE: {
                // Do nothing in these cases. We don't trim immutable nodes.
                break;
            }
        }
    }
    return MMDBW_SUCCESS;
}

static MMDBW_status
insert_record_into_current_record(MMDBW_tree_s *tree,
                                  MMDBW_record_s *current_record,
                                  MMDBW_network_s *network,
                                  MMDBW_record_s *new_record,
                                  MMDBW_merge_strategy merge_strategy) {
    // We only get called when we have a current_record with these record
    // types. There was previously logic for other types, but that was
    // confusing.
    if (current_record->type != MMDBW_RECORD_TYPE_EMPTY &&
        current_record->type != MMDBW_RECORD_TYPE_DATA &&
        current_record->type != MMDBW_RECORD_TYPE_NODE) {
        return MMDBW_INSERT_INVALID_RECORD_TYPE_ERROR;
    }

    if (current_record->type == MMDBW_RECORD_TYPE_EMPTY &&
        merge_strategy == MMDBW_MERGE_STRATEGY_ADD_ONLY_IF_PARENT_EXISTS) {
        // We do not create a new record when using "only if parent exists"
        return MMDBW_SUCCESS;
    }

    const char *merged_key = maybe_merge_records(
        tree, network, new_record, current_record, merge_strategy);

    MMDBW_status status = free_record_value(tree, current_record, false);
    if (status != MMDBW_SUCCESS) {
        return status;
    }

    // Update the record to match the new one. Replace what's there.
    current_record->type = new_record->type;
    if (new_record->type == MMDBW_RECORD_TYPE_DATA) {
        const char *const key = increment_data_reference_count(
            tree, merged_key == NULL ? new_record->value.key : merged_key);
        current_record->value.key = key;
    } else if (new_record->type == MMDBW_RECORD_TYPE_FIXED_NODE ||
               new_record->type == MMDBW_RECORD_TYPE_NODE ||
               new_record->type == MMDBW_RECORD_TYPE_ALIAS) {
        current_record->value.node = new_record->value.node;
    } else if (new_record->type == MMDBW_RECORD_TYPE_EMPTY ||
               new_record->type == MMDBW_RECORD_TYPE_FIXED_EMPTY) {
        current_record->value.key = NULL;
        current_record->value.node = NULL;
    } else {
        return MMDBW_INSERT_INVALID_RECORD_TYPE_ERROR;
    }

    if (merged_key) {
        decrement_data_reference_count(tree, merged_key);
    }

    return status;
}

static const char *maybe_merge_records(MMDBW_tree_s *tree,
                                       MMDBW_network_s *network,
                                       MMDBW_record_s *new_record,
                                       MMDBW_record_s *record_to_set,
                                       MMDBW_merge_strategy merge_strategy) {
    if (MMDBW_RECORD_TYPE_DATA != new_record->type ||
        merge_strategy == MMDBW_MERGE_STRATEGY_NONE) {
        return NULL;
    }

    /* This must come before the node pruning code in
       insert_record_for_network, as we only want to prune nodes where the
       merged record matches. */
    if (MMDBW_RECORD_TYPE_DATA != record_to_set->type
        // If the two keys are equal, there is no point in trying to merge
        // the contents.
        || strcmp(new_record->value.key, record_to_set->value.key) == 0) {
        return NULL;
    }

    char merge_cache_key[MERGE_KEY_SIZE + 1];
    snprintf(merge_cache_key,
             MERGE_KEY_SIZE + 1,
             "%d-%s-%s",
             merge_strategy,
             new_record->value.key,
             record_to_set->value.key);

    const char *cached_key = merge_cache_lookup(tree, merge_cache_key);
    if (cached_key != NULL) {
        const char *const new_key =
            increment_data_reference_count(tree, cached_key);
        return new_key;
    }

    SV *merged = merge_hashes_for_keys(tree,
                                       new_record->value.key,
                                       record_to_set->value.key,
                                       network,
                                       merge_strategy);

    SV *key_sv = key_for_data(merged);
    const char *const new_key =
        store_data_in_tree(tree, SvPVbyte_nolen(key_sv), merged);
    SvREFCNT_dec(key_sv);

    /* The ref count was incremented in store_data_in_tree */
    SvREFCNT_dec(merged);

    store_in_merge_cache(tree, merge_cache_key, new_key);

    return new_key;
}

static int network_bit_value(MMDBW_network_s *network, uint8_t current_bit) {
    return network->bytes[current_bit >> 3] & (1U << (~current_bit & 7));
}

static int tree_depth0(MMDBW_tree_s *tree) {
    return tree->ip_version == 6 ? 127 : 31;
}

SV *merge_hashes_for_keys(MMDBW_tree_s *tree,
                          const char *const key_from,
                          const char *const key_into,
                          MMDBW_network_s *network,
                          MMDBW_merge_strategy merge_strategy) {

    SV *data_from = data_for_key(tree, key_from);
    SV *data_into = data_for_key(tree, key_into);

    if (!(SvROK(data_from) && SvROK(data_into) &&
          SvTYPE(SvRV(data_from)) == SVt_PVHV &&
          SvTYPE(SvRV(data_into)) == SVt_PVHV)) {
        /* We added key_into earlier during insert_record_for_network, so we
           have to make sure here that it's removed again after we decide to
           not actually store this network. It might be nicer to not insert
           anything into the tree until we're sure we really want to. */
        decrement_data_reference_count(tree, key_from);

        bool is_ipv6 = tree->ip_version == 6;
        char address_string[is_ipv6 ? INET6_ADDRSTRLEN : INET_ADDRSTRLEN];
        inet_ntop(is_ipv6 ? AF_INET6 : AF_INET,
                  network->bytes,
                  address_string,
                  sizeof(address_string));

        croak("Cannot merge data records unless both records are hashes - "
              "inserting %s/%" PRIu8,
              address_string,
              network->prefix_length);
    }

    return merge_hashes(tree, data_from, data_into, merge_strategy);
}

static SV *merge_hashes(MMDBW_tree_s *tree,
                        SV *from,
                        SV *into,
                        MMDBW_merge_strategy merge_strategy) {
    HV *hash_from = (HV *)SvRV(from);
    HV *hash_into = (HV *)SvRV(into);
    HV *hash_new = newHV();

    merge_new_from_hash_into_hash(tree, hash_into, hash_new, false);
    merge_new_from_hash_into_hash(tree, hash_from, hash_new, merge_strategy);

    return newRV_noinc((SV *)hash_new);
}

// Note: unlike the other merge functions, this does _not_ replace existing
// values.
static void merge_new_from_hash_into_hash(MMDBW_tree_s *tree,
                                          HV *from,
                                          HV *to,
                                          MMDBW_merge_strategy merge_strategy) {
    (void)hv_iterinit(from);
    HE *he;
    while (NULL != (he = hv_iternext(from))) {
        STRLEN key_length;
        const char *const key = HePV(he, key_length);
        U32 hash = 0;
        SV *value = HeVAL(he);
        if (hv_exists(to, key, key_length)) {
            if (merge_strategy == MMDBW_MERGE_STRATEGY_RECURSE ||
                merge_strategy ==
                    MMDBW_MERGE_STRATEGY_ADD_ONLY_IF_PARENT_EXISTS) {
                SV **existing_value = hv_fetch(to, key, key_length, 0);
                if (existing_value == NULL) {
                    // This should never happen as we just did an hv_exists
                    croak("Received an unexpected NULL from hv_fetch");
                }

                value =
                    merge_values(tree, value, *existing_value, merge_strategy);
            } else {
                // We are replacing the current value
                hash = HeHASH(he);
                SvREFCNT_inc_simple_void_NN(value);
            }
        } else if (merge_strategy ==
                       MMDBW_MERGE_STRATEGY_ADD_ONLY_IF_PARENT_EXISTS &&
                   SvROK(value)) {
            continue;
        } else {
            hash = HeHASH(he);
            SvREFCNT_inc_simple_void_NN(value);
        }

        (void)hv_store(to, key, key_length, value, hash);
    }

    return;
}

static SV *merge_values(MMDBW_tree_s *tree,
                        SV *from,
                        SV *into,
                        MMDBW_merge_strategy merge_strategy) {
    if (SvROK(from) != SvROK(into)) {
        croak("Attempt to merge a reference value and non-refrence value");
    }

    if (!SvROK(from)) {
        // If the two values are scalars, we prefer the one in the hash being
        // inserted.
        SvREFCNT_inc_simple_void_NN(from);
        return from;
    }

    if (SvTYPE(SvRV(from)) == SVt_PVHV && SvTYPE(SvRV(into)) == SVt_PVHV) {
        return merge_hashes(tree, from, into, merge_strategy);
    }

    if (SvTYPE(SvRV(from)) == SVt_PVAV && SvTYPE(SvRV(into)) == SVt_PVAV) {
        return merge_arrays(tree, from, into, merge_strategy);
    }

    croak("Only arrayrefs, hashrefs, and scalars can be merged.");
}

static SV *merge_arrays(MMDBW_tree_s *tree,
                        SV *from,
                        SV *into,
                        MMDBW_merge_strategy merge_strategy) {
    AV *from_array = (AV *)SvRV(from);
    AV *into_array = (AV *)SvRV(into);

    // Note that av_len() is really the index of the last element. In newer
    // Perl versions, it is also called av_top_index() or av_tindex()
    SSize_t from_top_index = av_len(from_array);
    SSize_t into_top_index = av_len(into_array);

    SSize_t new_top_index =
        from_top_index > into_top_index ? from_top_index : into_top_index;

    AV *new_array = newAV();
    for (SSize_t i = 0; i <= new_top_index; i++) {
        SV *new_value = NULL;
        SV **from_value = av_fetch(from_array, i, 0);
        SV **into_value = av_fetch(into_array, i, 0);
        if (from_value != NULL && into_value != NULL) {
            new_value =
                merge_values(tree, *from_value, *into_value, merge_strategy);
        } else if (from_value != NULL) {
            if (merge_strategy ==
                    MMDBW_MERGE_STRATEGY_ADD_ONLY_IF_PARENT_EXISTS &&
                SvROK(*from_value)) {
                break;
            }
            new_value = *from_value;
            SvREFCNT_inc_simple_void_NN(new_value);
        } else if (into_value != NULL) {
            new_value = *into_value;
            SvREFCNT_inc_simple_void_NN(new_value);
        } else {
            croak("Received unexpected NULLs when merging arrays");
        }

        av_push(new_array, new_value);
    }
    return newRV_noinc((SV *)new_array);
}

SV *lookup_ip_address(MMDBW_tree_s *tree, const char *const ipstr) {
    bool is_ipv6_address = NULL != strchr(ipstr, ':');
    if (tree->ip_version == 4 && is_ipv6_address) {
        return &PL_sv_undef;
    }
    MMDBW_network_s network =
        resolve_network(tree, ipstr, is_ipv6_address ? 128 : 32);

    MMDBW_record_s *record_for_address;
    MMDBW_status status =
        find_record_for_network(tree, &network, &record_for_address);

    free_network(&network);

    if (MMDBW_SUCCESS != status) {
        croak("Received an unexpected NULL when looking up %s: %s",
              ipstr,
              status_error_message(status));
    }

    if (record_for_address->type == MMDBW_RECORD_TYPE_NODE ||
        record_for_address->type == MMDBW_RECORD_TYPE_FIXED_NODE ||
        record_for_address->type == MMDBW_RECORD_TYPE_ALIAS) {
        croak("WTF - found a node or alias record for an address lookup - "
              "%s" PRIu8,
              ipstr);
        return &PL_sv_undef;
    }

    if (record_for_address->type == MMDBW_RECORD_TYPE_EMPTY ||
        record_for_address->type == MMDBW_RECORD_TYPE_FIXED_EMPTY) {
        return &PL_sv_undef;
    }

    return newSVsv(data_for_key(tree, record_for_address->value.key));
}

static MMDBW_status find_record_for_network(MMDBW_tree_s *tree,
                                            MMDBW_network_s *network,
                                            MMDBW_record_s **record) {
    *record = &(tree->root_record);

    for (int current_bit = 0; current_bit < network->prefix_length;
         current_bit++) {

        MMDBW_node_s *node;
        if ((*record)->type == MMDBW_RECORD_TYPE_NODE ||
            (*record)->type == MMDBW_RECORD_TYPE_FIXED_NODE ||
            (*record)->type == MMDBW_RECORD_TYPE_ALIAS) {
            node = (*record)->value.node;
        } else {
            break;
        }

        if (network_bit_value(network, current_bit)) {
            *record = &(node->right_record);
        } else {
            *record = &(node->left_record);
        }
    }

    return MMDBW_SUCCESS;
}

static MMDBW_node_s *new_node_from_record(MMDBW_tree_s *tree,
                                          MMDBW_record_s *record) {
    MMDBW_node_s *node = new_node();
    if (record->type == MMDBW_RECORD_TYPE_DATA) {
        /* We only need to increment the reference count once as we are
           replacing the parent record */
        increment_data_reference_count(tree, record->value.key);

        node->left_record.type = MMDBW_RECORD_TYPE_DATA;
        node->left_record.value.key = record->value.key;

        node->right_record.type = MMDBW_RECORD_TYPE_DATA;
        node->right_record.value.key = record->value.key;
    }

    return node;
}

MMDBW_node_s *new_node() {
    MMDBW_node_s *node = checked_malloc(sizeof(MMDBW_node_s));

    node->number = 0;
    node->left_record.type = node->right_record.type = MMDBW_RECORD_TYPE_EMPTY;

    return node;
}

static MMDBW_status free_node_and_subnodes(MMDBW_tree_s *tree,
                                           MMDBW_node_s *node,
                                           bool remove_alias_and_fixed_nodes) {
    MMDBW_status status = free_record_value(
        tree, &(node->left_record), remove_alias_and_fixed_nodes);
    if (status != MMDBW_SUCCESS) {
        return status;
    }

    status = free_record_value(
        tree, &(node->right_record), remove_alias_and_fixed_nodes);
    if (status != MMDBW_SUCCESS) {
        return status;
    }

    free(node);
    return MMDBW_SUCCESS;
}

static MMDBW_status free_record_value(MMDBW_tree_s *tree,
                                      MMDBW_record_s *record,
                                      bool remove_alias_and_fixed_nodes) {
    if (record->type == MMDBW_RECORD_TYPE_FIXED_NODE &&
        !remove_alias_and_fixed_nodes) {
        return MMDBW_FREED_FIXED_NODE_ERROR;
    }

    if (record->type == MMDBW_RECORD_TYPE_FIXED_EMPTY &&
        !remove_alias_and_fixed_nodes) {
        return MMDBW_FREED_FIXED_EMPTY_ERROR;
    }

    if (record->type == MMDBW_RECORD_TYPE_NODE ||
        record->type == MMDBW_RECORD_TYPE_FIXED_NODE) {
        return free_node_and_subnodes(
            tree, record->value.node, remove_alias_and_fixed_nodes);
    }

    if (record->type == MMDBW_RECORD_TYPE_DATA) {
        decrement_data_reference_count(tree, record->value.key);
    }

    /* Alias nodes should only be removed explicitly. We can't just croak
       as it will leave the tree in an inconsistent state causing a segfault
       during unwinding. */
    if (record->type == MMDBW_RECORD_TYPE_ALIAS &&
        !remove_alias_and_fixed_nodes) {
        return MMDBW_FREED_ALIAS_NODE_ERROR;
    }
    return MMDBW_SUCCESS;
}

void assign_node_numbers(MMDBW_tree_s *tree) {
    tree->node_count = 0;
    start_iteration(tree, false, (void *)NULL, &assign_node_number);
}

static void assign_node_number(MMDBW_tree_s *tree,
                               MMDBW_node_s *node,
                               uint128_t UNUSED(network),
                               uint8_t UNUSED(depth),
                               void *UNUSED(args)) {
    node->number = tree->node_count++;
    return;
}

/* 16 bytes for an IP address, 1 byte for the prefix length */
#define FROZEN_RECORD_MAX_SIZE (16 + 1 + SHA1_KEY_LENGTH)
#define FROZEN_NODE_MAX_SIZE (FROZEN_RECORD_MAX_SIZE * 2)

/* 17 bytes of NULLs followed by something that cannot be an SHA1 key are a
   clear indicator that there are no more frozen networks in the buffer. */
#define SEVENTEEN_NULLS "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
#define FREEZE_SEPARATOR "not an SHA1 key"
/* We subtract 1 as we treat this as a sequence of bytes rather than a null
   terminated string. */
#define FREEZE_SEPARATOR_LENGTH (sizeof(FREEZE_SEPARATOR) - 1)

void freeze_tree(MMDBW_tree_s *tree,
                 char *filename,
                 char *frozen_params,
                 size_t frozen_params_size) {
    FILE *file = fopen(filename, "wb");
    if (!file) {
        croak("Could not open file %s: %s", filename, strerror(errno));
    }

    freeze_args_s args = {
        .file = file,
        .filename = filename,
    };

    freeze_to_file(&args, &frozen_params_size, 4);
    freeze_to_file(&args, frozen_params, frozen_params_size);

    freeze_search_tree(tree, &args);

    freeze_to_file(&args, SEVENTEEN_NULLS, 17);
    freeze_to_file(&args, FREEZE_SEPARATOR, FREEZE_SEPARATOR_LENGTH);

    freeze_data_to_file(&args, tree);

    if (fclose(file) != 0) {
        croak("Could not close file %s: %s", filename, strerror(errno));
    }

    /* When the hash is _freed_, Perl decrements the ref count for each value
     * so we don't need to mess with them. */
    SvREFCNT_dec((SV *)args.data_hash);
}

static void freeze_search_tree(MMDBW_tree_s *tree, freeze_args_s *args) {
    if (tree->root_record.type == MMDBW_RECORD_TYPE_DATA) {
        croak("A tree that only contains a data record for /0 cannot be "
              "frozen");
    }

    if (tree->root_record.type == MMDBW_RECORD_TYPE_NODE ||
        tree->root_record.type == MMDBW_RECORD_TYPE_FIXED_NODE) {
        start_iteration(tree, false, (void *)args, &freeze_node);
        return;
    }

    croak("Unexected root record type when freezing tree: %s",
          record_type_name(tree->root_record.type));
}

static void freeze_node(MMDBW_tree_s *tree,
                        MMDBW_node_s *node,
                        uint128_t network,
                        uint8_t depth,
                        void *void_args) {
    freeze_args_s *args = (freeze_args_s *)void_args;

    const uint8_t next_depth = depth + 1;

    if (node->left_record.type == MMDBW_RECORD_TYPE_DATA) {
        freeze_data_record(
            tree, network, next_depth, node->left_record.value.key, args);
    }

    if (node->right_record.type == MMDBW_RECORD_TYPE_DATA) {
        uint128_t right_network = flip_network_bit(tree, network, depth);
        freeze_data_record(tree,
                           right_network,
                           next_depth,
                           node->right_record.value.key,
                           args);
    }
}

static void freeze_data_record(MMDBW_tree_s *UNUSED(tree),
                               uint128_t network,
                               uint8_t depth,
                               const char *key,
                               freeze_args_s *args) {
    /* It'd save some space to shrink this to 4 bytes for IPv4-only trees, but
     * that would also complicated thawing quite a bit. */
    freeze_to_file(args, &network, 16);
    freeze_to_file(args, &(depth), 1);
    freeze_to_file(args, (char *)key, SHA1_KEY_LENGTH);
}

static void freeze_to_file(freeze_args_s *args, void *data, size_t size) {
    checked_fwrite(args->file, args->filename, data, size);
}

static void freeze_data_to_file(freeze_args_s *args, MMDBW_tree_s *tree) {
    HV *data_hash = newHV();

    MMDBW_data_hash_s *item, *tmp;
    HASH_ITER(hh, tree->data_table, item, tmp) {
        SvREFCNT_inc_simple_void_NN(item->data_sv);
        (void)hv_store(data_hash, item->key, SHA1_KEY_LENGTH, item->data_sv, 0);
    }

    SV *frozen_data = freeze_hash(data_hash);
    STRLEN frozen_data_size;
    char *frozen_data_chars = SvPV(frozen_data, frozen_data_size);

    checked_fwrite(
        args->file, args->filename, &frozen_data_size, sizeof(STRLEN));
    checked_fwrite(
        args->file, args->filename, frozen_data_chars, frozen_data_size);

    SvREFCNT_dec(frozen_data);
    SvREFCNT_dec((SV *)data_hash);
}

static SV *freeze_hash(HV *hash) {
    dSP;
    ENTER;
    SAVETMPS;

    SV *hashref = sv_2mortal(newRV_inc((SV *)hash));

    PUSHMARK(SP);
    EXTEND(SP, 1);
    PUSHs(hashref);
    PUTBACK;

    int count = call_pv("Sereal::Encoder::encode_sereal", G_SCALAR);

    SPAGAIN;

    if (count != 1) {
        croak("Expected 1 item back from Sereal::Encoder::encode_sereal call");
    }

    SV *frozen = POPs;
    if (!SvPOK(frozen)) {
        croak("The Sereal::Encoder::encode_sereal sub returned an SV which is "
              "not SvPOK!");
    }

    /* The SV will be mortal so it's about to lose a ref with the FREETMPS
       call below. */
    SvREFCNT_inc_simple_void_NN(frozen);

    PUTBACK;
    FREETMPS;
    LEAVE;

    return frozen;
}

MMDBW_tree_s *thaw_tree(char *filename,
                        uint32_t initial_offset,
                        uint8_t ip_version,
                        uint8_t record_size,
                        MMDBW_merge_strategy merge_strategy,
                        const bool alias_ipv6,
                        const bool remove_reserved_networks) {
#ifdef WIN32
    int fd = open(filename, O_RDONLY);
#else
    int fd = open(filename, O_RDONLY, 0);
#endif
    if (fd == -1) {
        croak("Could not open file %s: %s", filename, strerror(errno));
    }

    struct stat fileinfo;
    if (fstat(fd, &fileinfo) == -1) {
        close(fd);
        croak("Could not stat file: %s: %s", filename, strerror(errno));
    }

    uint8_t *buffer =
        (uint8_t *)mmap(NULL, fileinfo.st_size, PROT_READ, MAP_SHARED, fd, 0);
    close(fd);

    buffer += initial_offset;

    MMDBW_tree_s *tree = new_tree(ip_version,
                                  record_size,
                                  merge_strategy,
                                  alias_ipv6,
                                  remove_reserved_networks);

    thawed_network_s *thawed;
    while (NULL != (thawed = thaw_network(tree, &buffer))) {
        // We should never need to merge when thawing a tree.
        MMDBW_status status =
            insert_record_for_network(tree,
                                      thawed->network,
                                      thawed->record,
                                      MMDBW_MERGE_STRATEGY_NONE,
                                      true);
        free_network(thawed->network);
        free(thawed->network);
        if (thawed->record->type == MMDBW_RECORD_TYPE_DATA) {
            free((char *)thawed->record->value.key);
        }
        free(thawed->record);
        free(thawed);
        if (status != MMDBW_SUCCESS) {
            croak(status_error_message(status));
        }
    }

    STRLEN frozen_data_size = thaw_strlen(&buffer);

    /* per perlapi newSVpvn copies the string */
    SV *data_to_decode = sv_2mortal(newSVpvn((char *)buffer, frozen_data_size));
    HV *data_hash = thaw_data_hash(data_to_decode);

    hv_iterinit(data_hash);
    char *key;
    I32 keylen;
    SV *value;
    while (NULL != (value = hv_iternextsv(data_hash, &key, &keylen))) {
        set_stored_data_in_tree(tree, key, value);
    }

    SvREFCNT_dec((SV *)data_hash);

    return tree;
}

static uint8_t thaw_uint8(uint8_t **buffer) {
    uint8_t value;
    memcpy(&value, *buffer, 1);
    *buffer += 1;
    return value;
}

static thawed_network_s *thaw_network(MMDBW_tree_s *tree, uint8_t **buffer) {
    uint128_t start_ip = thaw_uint128(buffer);
    uint8_t prefix_length = thaw_uint8(buffer);

    if (start_ip == 0 && prefix_length == 0) {
        uint8_t *maybe_separator = thaw_bytes(buffer, FREEZE_SEPARATOR_LENGTH);
        if (memcmp(maybe_separator,
                   FREEZE_SEPARATOR,
                   FREEZE_SEPARATOR_LENGTH) == 0) {

            free(maybe_separator);
            return NULL;
        }

        croak("Found a ::0/0 network but that should never happen!");
    }

    uint8_t *start_ip_bytes = (uint8_t *)&start_ip;
    uint8_t temp;
    for (int i = 0; i < 8; i++) {
        temp = start_ip_bytes[i];
        start_ip_bytes[i] = start_ip_bytes[15 - i];
        start_ip_bytes[15 - i] = temp;
    }

    thawed_network_s *thawed = checked_malloc(sizeof(thawed_network_s));

    uint8_t *bytes;
    if (tree->ip_version == 4) {
        bytes = checked_malloc(4);
        memcpy(bytes, start_ip_bytes + 12, 4);
    } else {
        bytes = checked_malloc(16);
        memcpy(bytes, &start_ip, 16);
    }

    MMDBW_network_s network = {
        .bytes = bytes,
        .prefix_length = prefix_length,
    };

    thawed->network = checked_malloc(sizeof(MMDBW_network_s));
    memcpy(thawed->network, &network, sizeof(MMDBW_network_s));

    MMDBW_record_s *record = checked_malloc(sizeof(MMDBW_record_s));
    record->type = MMDBW_RECORD_TYPE_DATA;

    record->value.key = thaw_data_key(buffer);

    thawed->record = record;

    return thawed;
}

static uint8_t *thaw_bytes(uint8_t **buffer, size_t size) {
    uint8_t *value = checked_malloc(size);
    memcpy(value, *buffer, size);
    *buffer += size;
    return value;
}

static uint128_t thaw_uint128(uint8_t **buffer) {
    uint128_t value;
    memcpy(&value, *buffer, 16);
    *buffer += 16;
    return value;
}

static STRLEN thaw_strlen(uint8_t **buffer) {
    STRLEN value;
    memcpy(&value, *buffer, sizeof(STRLEN));
    *buffer += sizeof(STRLEN);
    return value;
}

static const char *thaw_data_key(uint8_t **buffer) {
    char *value = checked_malloc(SHA1_KEY_LENGTH + 1);
    memcpy(value, *buffer, SHA1_KEY_LENGTH);
    *buffer += SHA1_KEY_LENGTH;
    value[SHA1_KEY_LENGTH] = '\0';
    return (const char *)value;
}

static HV *thaw_data_hash(SV *data_to_decode) {
    dSP;
    ENTER;
    SAVETMPS;

    PUSHMARK(SP);
    EXTEND(SP, 1);
    PUSHs(data_to_decode);
    PUTBACK;

    int count = call_pv("Sereal::Decoder::decode_sereal", G_SCALAR);

    SPAGAIN;

    if (count != 1) {
        croak("Expected 1 item back from Sereal::Decoder::decode_sereal call");
    }

    SV *thawed = POPs;
    if (!SvROK(thawed)) {
        croak("The Sereal::Decoder::decode_sereal sub returned an SV which is "
              "not SvROK!");
    }

    SV *data_hash = SvREFCNT_inc_simple_NN(SvRV(thawed));

    PUTBACK;
    FREETMPS;
    LEAVE;

    return (HV *)data_hash;
}

void write_search_tree(MMDBW_tree_s *tree,
                       SV *output,
                       SV *root_data_type,
                       SV *serializer) {
    assign_node_numbers(tree);

    /* This is a gross way to get around the fact that with C function
     * pointers we can't easily pass different params to different
     * callbacks. */
    encode_args_s args = {.output_io = IoOFP(sv_2io(output)),
                          .root_data_type = root_data_type,
                          .serializer = serializer,
                          .data_pointer_cache = newHV()};

    start_iteration(tree, false, (void *)&args, &encode_node);

    /* When the hash is _freed_, Perl decrements the ref count for each value
     * so we don't need to mess with them. */
    SvREFCNT_dec((SV *)args.data_pointer_cache);

    return;
}

static void encode_node(MMDBW_tree_s *tree,
                        MMDBW_node_s *node,
                        uint128_t UNUSED(network),
                        uint8_t UNUSED(depth),
                        void *void_args) {
    encode_args_s *args = (encode_args_s *)void_args;

    check_record_sanity(node, &(node->left_record), "left");
    check_record_sanity(node, &(node->right_record), "right");

    uint32_t left =
        htonl(record_value_as_number(tree, &(node->left_record), args));
    uint32_t right =
        htonl(record_value_as_number(tree, &(node->right_record), args));

    uint8_t *left_bytes = (uint8_t *)&left;
    uint8_t *right_bytes = (uint8_t *)&right;

    if (tree->record_size == 24) {
        check_perlio_result(PerlIO_printf(args->output_io,
                                          "%c%c%c%c%c%c",
                                          left_bytes[1],
                                          left_bytes[2],
                                          left_bytes[3],
                                          right_bytes[1],
                                          right_bytes[2],
                                          right_bytes[3]),
                            6,
                            "PerlIO_printf");
    } else if (tree->record_size == 28) {
        check_perlio_result(
            PerlIO_printf(args->output_io,
                          "%c%c%c%c%c%c%c",
                          left_bytes[1],
                          left_bytes[2],
                          left_bytes[3],
                          (left_bytes[0] << 4) | (right_bytes[0] & 15),
                          right_bytes[1],
                          right_bytes[2],
                          right_bytes[3]),
            7,
            "PerlIO_printf");
    } else {
        check_perlio_result(PerlIO_printf(args->output_io,
                                          "%c%c%c%c%c%c%c%c",
                                          left_bytes[0],
                                          left_bytes[1],
                                          left_bytes[2],
                                          left_bytes[3],
                                          right_bytes[0],
                                          right_bytes[1],
                                          right_bytes[2],
                                          right_bytes[3]),
                            8,
                            "PerlIO_printf");
    }
}

/* Note that for data records, we will ensure that the key they contain does
 * match a data record in the record_value_as_number() subroutine. */
static void
check_record_sanity(MMDBW_node_s *node, MMDBW_record_s *record, char *side) {
    if (record->type == MMDBW_RECORD_TYPE_NODE ||
        record->type == MMDBW_RECORD_TYPE_FIXED_NODE) {
        if (record->value.node->number == node->number) {
            croak("%s record of node %" PRIu32 " points to the same node",
                  side,
                  node->number);
        }

        if (record->value.node->number < node->number) {
            croak("%s record of node %" PRIu32
                  " points to a node number (%" PRIu32 ")",
                  side,
                  node->number,
                  record->value.node->number);
        }
    }

    // This is a simple check that we aren't pointing at the tree root.
    if (record->type == MMDBW_RECORD_TYPE_ALIAS) {
        if (record->value.node->number == 0) {
            croak("%s record of node %" PRIu32 " is an alias to node 0",
                  side,
                  node->number);
        }
    }
}

static uint32_t record_value_as_number(MMDBW_tree_s *tree,
                                       MMDBW_record_s *record,
                                       encode_args_s *args) {
    uint32_t record_value = 0;

    switch (record->type) {
        case MMDBW_RECORD_TYPE_FIXED_EMPTY:
        case MMDBW_RECORD_TYPE_EMPTY: {
            // Say that the IP isn't here.
            record_value = tree->node_count;
            break;
        }
        case MMDBW_RECORD_TYPE_NODE:
        case MMDBW_RECORD_TYPE_ALIAS:
        case MMDBW_RECORD_TYPE_FIXED_NODE: {
            record_value = record->value.node->number;
            break;
        }
        case MMDBW_RECORD_TYPE_DATA: {
            SV **cache_record = hv_fetch(args->data_pointer_cache,
                                         record->value.key,
                                         SHA1_KEY_LENGTH,
                                         0);
            if (cache_record) {
                /* It is ok to return this without the size check below as it
                   would have already croaked when it was inserted if it was too
                   big. */
                return SvIV(*cache_record);
            }

            SV *data = newSVsv(data_for_key(tree, record->value.key));
            if (!SvOK(data)) {
                croak("No data associated with key - %s", record->value.key);
            }

            dSP;
            ENTER;
            SAVETMPS;

            PUSHMARK(SP);
            EXTEND(SP, 5);
            PUSHs(args->serializer);
            PUSHs(args->root_data_type);
            mPUSHs(data);
            PUSHs(&PL_sv_undef);
            mPUSHp(record->value.key, strlen(record->value.key));
            PUTBACK;

            int count = call_method("store_data", G_SCALAR);

            SPAGAIN;

            if (count != 1) {
                croak("Expected 1 item back from ->store_data() call");
            }

            SV *rval = POPs;
            if (!(SvIOK(rval) || SvUOK(rval))) {
                croak("The serializer's store_data() method returned an SV "
                      "which is not SvIOK or SvUOK!");
            }
            uint32_t position = (uint32_t)SvUV(rval);

            PUTBACK;
            FREETMPS;
            LEAVE;

            record_value =
                position + tree->node_count + DATA_SECTION_SEPARATOR_SIZE;

            SV *value = newSViv(record_value);
            (void)hv_store(args->data_pointer_cache,
                           record->value.key,
                           SHA1_KEY_LENGTH,
                           value,
                           0);
            break;
        }
    }

    if (record_value > max_record_value(tree)) {
        croak("Node value of %" PRIu32 " exceeds the record size of %" PRIu8
              " bits",
              record_value,
              tree->record_size);
    }

    return record_value;
}

uint32_t max_record_value(MMDBW_tree_s *tree) {
    uint8_t record_size = tree->record_size;
    return record_size == 32 ? UINT32_MAX : (uint32_t)(1 << record_size) - 1;
}

void start_iteration(MMDBW_tree_s *tree,
                     bool depth_first,
                     void *args,
                     MMDBW_iterator_callback callback) {
    uint128_t network = 0;
    uint8_t depth = 0;

    // We disallow this as the callback is based on nodes rather than records,
    // and changing that is a rabbit hole that I don't want to go down
    // currently. (I stuck my head in and regretted it.)
    if (MMDBW_RECORD_TYPE_NODE != tree->root_record.type &&
        MMDBW_RECORD_TYPE_FIXED_NODE != tree->root_record.type) {
        croak("Iteration is not currently allowed in trees with no nodes. "
              "Record type: %s",
              record_type_name(tree->root_record.type));
    }

    iterate_tree(
        tree, &tree->root_record, network, depth, depth_first, args, callback);

    return;
}

static void iterate_tree(MMDBW_tree_s *tree,
                         MMDBW_record_s *record,
                         uint128_t network,
                         const uint8_t depth,
                         bool depth_first,
                         void *args,
                         MMDBW_iterator_callback callback) {
    if (depth > tree_depth0(tree) + 1) {
        char ip[INET6_ADDRSTRLEN];
        integer_to_ip_string(tree->ip_version, network, ip, sizeof(ip));
        croak("Depth during iteration is greater than 127 (depth: %u, "
              "start IP: %s)! The tree is wonky.\n",
              depth,
              ip);
    }

    if (record->type == MMDBW_RECORD_TYPE_NODE ||
        record->type == MMDBW_RECORD_TYPE_FIXED_NODE) {
        MMDBW_node_s *node = record->value.node;

        if (!depth_first) {
            callback(tree, node, network, depth, args);
        }

        iterate_tree(tree,
                     &node->left_record,
                     network,
                     depth + 1,
                     depth_first,
                     args,
                     callback);

        if (depth_first) {
            callback(tree, node, network, depth, args);
        }

        iterate_tree(tree,
                     &node->right_record,
                     flip_network_bit(tree, network, depth),
                     depth + 1,
                     depth_first,
                     args,
                     callback);
    }
}

uint128_t
flip_network_bit(MMDBW_tree_s *tree, uint128_t network, uint8_t depth) {
    return network | ((uint128_t)1 << (tree_depth0(tree) - depth));
}

static SV *key_for_data(SV *data) {
    dSP;
    ENTER;
    SAVETMPS;

    PUSHMARK(SP);
    EXTEND(SP, 1);
    PUSHs(data);
    PUTBACK;

    const char *const sub = "MaxMind::DB::Writer::Util::key_for_data";
    int count = call_pv(sub, G_SCALAR);

    SPAGAIN;

    if (count != 1) {
        croak("Expected 1 item back from %s() call", sub);
    }

    SV *key = POPs;
    SvREFCNT_inc_simple_void_NN(key);

    PUTBACK;
    FREETMPS;
    LEAVE;

    return key;
}

SV *data_for_key(MMDBW_tree_s *tree, const char *const key) {
    MMDBW_data_hash_s *data = NULL;
    HASH_FIND(hh, tree->data_table, key, strlen(key), data);

    if (NULL != data) {
        return data->data_sv;
    } else {
        return &PL_sv_undef;
    }
}

static const char *merge_cache_lookup(MMDBW_tree_s *tree,
                                      char *merge_cache_key) {
    MMDBW_merge_cache_s *cache = NULL;
    HASH_FIND(hh, tree->merge_cache, merge_cache_key, MERGE_KEY_SIZE, cache);

    if (!cache) {
        return NULL;
    }

    // We have to check that the value has not been removed from the data
    // table
    MMDBW_data_hash_s *data = NULL;
    HASH_FIND(hh, tree->data_table, cache->value, SHA1_KEY_LENGTH, data);
    if (data != NULL) {
        return cache->value;
    }

    // Item has been removed from data table. Remove the cached merge too.
    HASH_DEL(tree->merge_cache, cache);
    return NULL;
}

static void store_in_merge_cache(MMDBW_tree_s *tree,
                                 char *merge_cache_key,
                                 const char *const new_key) {
    MMDBW_merge_cache_s *data = checked_malloc(sizeof(MMDBW_merge_cache_s));
    data->value = checked_malloc(SHA1_KEY_LENGTH + 1);
    strncpy((char *)data->value, new_key, SHA1_KEY_LENGTH + 1);

    data->key = checked_malloc(MERGE_KEY_SIZE + 1);
    strncpy((char *)data->key, merge_cache_key, MERGE_KEY_SIZE + 1);

    HASH_ADD_KEYPTR(hh, tree->merge_cache, data->key, MERGE_KEY_SIZE, data);
}

void free_tree(MMDBW_tree_s *tree) {
    free_record_value(tree, &tree->root_record, true);
    free_merge_cache(tree);

    int hash_count = HASH_COUNT(tree->data_table);
    if (0 != hash_count) {
        croak("%d elements left in data table after freeing all nodes!",
              hash_count);
    }

    free(tree);
}

void free_merge_cache(MMDBW_tree_s *tree) {
    MMDBW_merge_cache_s *cache, *tmp = NULL;
    HASH_ITER(hh, tree->merge_cache, cache, tmp) {
        HASH_DEL(tree->merge_cache, cache);
        free((void *)cache->key);
        free((void *)cache->value);
        free(cache);
    }
}

static void *checked_malloc(size_t size) {
    void *ptr = malloc(size);
    if (!ptr) {
        abort();
    }

    return ptr;
}

static void
checked_fwrite(FILE *file, char *filename, void *buffer, size_t count) {
    size_t result = fwrite(buffer, 1, count, file);
    if (result != count) {
        fclose(file);
        croak("Write to %s did not write the expected amount of data (wrote "
              "%zu instead of %zu): %s",
              filename,
              result,
              count,
              strerror(errno));
    }
}

static void check_perlio_result(SSize_t result, SSize_t expected, char *op) {
    if (result < 0) {
        croak("%s operation failed: %s\n", op, strerror(result));
    } else if (result != expected) {
        croak("%s operation wrote %zd bytes when we expected to write %zd",
              op,
              result,
              expected);
    }
}

static char *status_error_message(MMDBW_status status) {
    switch (status) {
        case MMDBW_SUCCESS:
            return "Success";
        case MMDBW_INSERT_INTO_ALIAS_NODE_ERROR:
            return "Attempted to insert into an aliased network.";
        case MMDBW_INSERT_INVALID_RECORD_TYPE_ERROR:
            return "Invalid record type given to insert.";
        case MMDBW_FREED_ALIAS_NODE_ERROR:
            return "Attempted to free an IPv4 alias node. Did you try to "
                   "overwrite an alias network?";
        case MMDBW_FREED_FIXED_EMPTY_ERROR:
            return "Attempted to free a fixed empty node. This should never "
                   "happen.";
        case MMDBW_FREED_FIXED_NODE_ERROR:
            return "Attempted to free a fixed node. This should never happen.";
        case MMDBW_ALIAS_OVERWRITE_ATTEMPT_ERROR:
            return "Attempted to overwrite an aliased network.";
        case MMDBW_FIXED_NODE_OVERWRITE_ATTEMPT_ERROR:
            return "Attempted to overwrite a fixed node.";
        case MMDBW_RESOLVING_IP_ERROR:
            return "Failed to resolve IP address.";
    }
    // We should get a compile time warning if an enum is missing
    return "Unknown error";
}

static const char *record_type_name(MMDBW_record_type type) {
    switch (type) {
        case MMDBW_RECORD_TYPE_EMPTY:
            return "empty";
        case MMDBW_RECORD_TYPE_FIXED_EMPTY:
            return "fixed_empty";
        case MMDBW_RECORD_TYPE_DATA:
            return "data";
        case MMDBW_RECORD_TYPE_NODE:
            return "node";
        case MMDBW_RECORD_TYPE_FIXED_NODE:
            return "fixed_node";
        case MMDBW_RECORD_TYPE_ALIAS:
            return "alias";
    }
    return "unknown type";
}
