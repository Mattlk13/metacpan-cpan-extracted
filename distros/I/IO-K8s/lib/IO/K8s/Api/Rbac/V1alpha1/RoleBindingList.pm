package IO::K8s::Api::Rbac::V1alpha1::RoleBindingList;
  use Moose;
  use IO::K8s;

  has 'apiVersion' => (is => 'ro', isa => 'Str'  );
  has 'items' => (is => 'ro', isa => 'ArrayRef[IO::K8s::Api::Rbac::V1alpha1::RoleBinding]'  );
  has 'kind' => (is => 'ro', isa => 'Str'  );
  has 'metadata' => (is => 'ro', isa => 'IO::K8s::Apimachinery::Pkg::Apis::Meta::V1::ListMeta'  );

  sub to_json { IO::K8s->new->object_to_json(shift) }
1;
