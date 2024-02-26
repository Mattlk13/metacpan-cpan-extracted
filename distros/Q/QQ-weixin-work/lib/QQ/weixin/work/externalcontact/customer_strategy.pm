package QQ::weixin::work::externalcontact::customer_strategy;

=encoding utf8

=head1 Name

QQ::weixin::work::externalcontact::customer_strategy

=head1 DESCRIPTION

客户联系规则组管理
最后更新：2023/12/01

=head2 SYNOPSIS

L<https://developer.work.weixin.qq.com/document/path/94883>

=cut

use strict;
use base qw(QQ::weixin::work::externalcontact);
use Encode;
use LWP::UserAgent;
use JSON;
use utf8;

our $VERSION = '0.10';
our @EXPORT = qw/ list get get_range create edit del /;

=head1 FUNCTION

=head2 list(access_token, hash);

获取规则组列表

=head2 SYNOPSIS

L<https://developer.work.weixin.qq.com/document/path/94883#获取规则组列表>

=head3 请求说明：

企业可通过此接口获取企业配置的所有客户规则组id列表。

=head4 请求包结构体为：

    {
		"cursor":"CURSOR",
		"limit":1000
	}

=head4 参数说明：

	参数	            必须	说明
    access_token	是	调用接口凭证
	cursor	否	分页查询游标，首次调用可不填
	limit	否	分页大小,默认为1000，最大不超过1000

=head4 权限说明：

调用客户联系规则组接口的应用需要满足如下的权限：

	应用类型	权限要求
	自建应用	配置到「客户联系 可调用接口的应用」中
	代开发应用	具有「管理客户联系规则组」权限
	第三方应用	具有「管理客户联系规则组」权限

提示
应用仅能获取和管理由本应用创建的规则组

注： 从2023年12月1日0点起，不再支持通过系统应用secret调用接口，存量企业暂不受影响 查看详情


=head3 RETURN 返回结果：

    {
		"errcode": 0,
		"errmsg": "ok",
		"strategy":
		[
			{
				"strategy_id":1
			},
			{
				"strategy_id":2
			}
		],
		"next_cursor":"NEXT_CURSOR"
	}

=head4 RETURN 参数说明：

	参数	        说明
    errcode	返回码
	errmsg	对返回码的文本描述内容
	strategy_id	规则组id
	next_cursor	分页游标，用于查询下一个分页的数据，无更多数据时不返回

=cut

sub list {
    if ( @_ && $_[0] && ref $_[1] eq 'HASH' ) {
        my $access_token = $_[0];
        my $json = $_[1];
        my $ua = LWP::UserAgent->new;
        $ua->timeout(30);
        $ua->env_proxy;

        my $response = $ua->post("https://qyapi.weixin.qq.com/cgi-bin/externalcontact/customer_strategy/list?access_token=$access_token",Content => to_json($json,{allow_nonref=>1}),Content_type =>'application/json');
        if ($response->is_success) {
            return from_json($response->decoded_content,{utf8 => 1, allow_nonref => 1});
        }

    }
    return 0;
}

=head2 get(access_token, hash);

获取规则组详情

=head2 SYNOPSIS

L<https://developer.work.weixin.qq.com/document/path/94883#获取规则组详情>

=head3 请求说明：

企业可以通过此接口获取某个客户规则组的详细信息。

=head4 请求包结构体为：

    {
		"strategy_id":1
	}

=head4 参数说明：

	参数	            必须	说明
    access_token	是	调用接口凭证
	strategy_id	是	规则组id

=head4 权限说明：

=head3 RETURN 返回结果：

	{
		"errcode": 0,
		"errmsg": "ok",
		"strategy": {
			"strategy_id":1,
			"parent_id":0,
			"strategy_name": "NAME",
			"create_time": 1557838797,
			"admin_list":[
				"zhangsan",
				"lisi"
			],
			"privilege":
			{
				"view_customer_list":true,
				"view_customer_data":true,
				"view_room_list":true,
				"contact_me":true,
				"join_room":true,
				"share_customer":false,
				"oper_resign_customer":true,
				"oper_resign_group":true,
				"send_customer_msg":true,
				"edit_welcome_msg":true,
				"view_behavior_data":true,
				"view_room_data":true,
				"send_group_msg":true,
				"room_deduplication":true,
				"rapid_reply":true,
				"onjob_customer_transfer":true,
				"edit_anti_spam_rule":true,
				"export_customer_list":true,
				"export_customer_data":true,
				"export_customer_group_list":true,
				"manage_customer_tag":true
			}
		}
	}

=head4 RETURN 参数说明：

	参数	        说明
    errcode	返回码
	errmsg	对返回码的文本描述内容
	strategy_id	规则组id
	parent_id	父规则组id， 如果当前规则组没父规则组，则为0
	strategy_name	规则组名称
	create_time	规则组创建时间戳
	admin_list	规则组管理员userid列表
	privilege.view_customer_list	查看客户列表，基础权限，不可取消
	privilege.view_customer_data	查看客户统计数据，基础权限，不可取消
	privilege.view_room_list	查看群聊列表，基础权限，不可取消
	privilege.contact_me	可使用联系我，基础权限，不可取消
	privilege.join_room	可加入群聊，基础权限，不可取消
	privilege.share_customer	允许分享客户给其他成员，默认为true
	privilege.oper_resign_customer	允许分配离职成员客户，默认为true
	privilege.oper_resign_group	允许分配离职成员客户群，默认为true
	privilege.send_customer_msg	允许给企业客户发送消息，默认为true
	privilege.edit_welcome_msg	允许配置欢迎语，默认为true
	privilege.view_behavior_data	允许查看成员联系客户统计
	privilege.view_room_data	允许查看群聊数据统计，默认为true
	privilege.send_group_msg	允许发送消息到企业的客户群，默认为true
	privilege.room_deduplication	允许对企业客户群进行去重，默认为true
	privilege.rapid_reply	配置快捷回复，默认为true
	privilege.onjob_customer_transfer	转接在职成员的客户，默认为true
	privilege.edit_anti_spam_rule	编辑企业成员防骚扰规则，默认为true
	privilege.export_customer_list	导出客户列表，默认为true
	privilege.export_customer_data	导出成员客户统计，默认为true
	privilege.export_customer_group_list	导出客户群列表，默认为true
	privilege.manage_customer_tag	配置企业客户标签，默认为true

如果规则组具有父规则组则其管理范围必须是父规则组的子集。

=cut

sub get {
    if ( @_ && $_[0] && ref $_[1] eq 'HASH' ) {
        my $access_token = $_[0];
        my $json = $_[1];
        my $ua = LWP::UserAgent->new;
        $ua->timeout(30);
        $ua->env_proxy;

        my $response = $ua->post("https://qyapi.weixin.qq.com/cgi-bin/externalcontact/customer_strategy/get?access_token=$access_token",Content => to_json($json,{allow_nonref=>1}),Content_type =>'application/json');
        if ($response->is_success) {
            return from_json($response->decoded_content,{utf8 => 1, allow_nonref => 1});
        }

    }
    return 0;
}

=head2 get_range(access_token, hash);

获取规则组管理范围

=head2 SYNOPSIS

L<https://developer.work.weixin.qq.com/document/path/94883#获取规则组管理范围>

=head3 请求说明：

企业可通过此接口获取某个客户规则组管理的成员和部门列表。

=head4 请求包结构体为：

    {
		"strategy_id":1,
		"cursor":"CURSOR",
		"limit":1000
	}

=head4 参数说明：

	参数	            必须	说明
    access_token	是	调用接口凭证
	strategy_id	是	规则组id
	cursor	否	分页游标
	limit	否	每个分页的成员/部门节点数，默认为1000，最大为1000

=head4 权限说明：

=head3 RETURN 返回结果：

    {
		"errcode": 0,
		"errmsg": "ok",
		"range":
		[
			{
				"type":1,
				"userid":"zhangsan"
			},
			{
				"type":2,
				"partyid":1
			}
		],
		"next_cursor":"NEXT_CURSOR"
	}

=head4 RETURN 参数说明：

	参数	        说明
    errcode	返回码
	errmsg	对返回码的文本描述内容
	range.type	节点类型，1-成员 2-部门
	range.userid	管理范围内配置的成员userid，仅type为1时返回
	item.partyid	管理范围内配置的部门partyid，仅type为2时返回
	next_cursor	分页游标，用于查询下一个分页的数据，无更多数据时不返回

=cut

sub get_range {
    if ( @_ && $_[0] && ref $_[1] eq 'HASH' ) {
        my $access_token = $_[0];
        my $json = $_[1];
        my $ua = LWP::UserAgent->new;
        $ua->timeout(30);
        $ua->env_proxy;

        my $response = $ua->post("https://qyapi.weixin.qq.com/cgi-bin/externalcontact/customer_strategy/get_range?access_token=$access_token",Content => to_json($json,{allow_nonref=>1}),Content_type =>'application/json');
        if ($response->is_success) {
            return from_json($response->decoded_content,{utf8 => 1, allow_nonref => 1});
        }

    }
    return 0;
}

=head2 create(access_token, hash);

创建新的规则组

=head2 SYNOPSIS

L<https://developer.work.weixin.qq.com/document/path/94883#创建新的规则组>

=head3 请求说明：

企业可通过此接口创建一个新的客户规则组。该接口仅支持串行调用，请勿并发创建规则组。

=head4 请求包结构体为：

	{
		"parent_id":0,
		"strategy_name": "NAME",
		"admin_list":[
			"zhangsan",
			"lisi"
		],
		"privilege":
		{
				"view_customer_list":true,
				"view_customer_data":true,
				"view_room_list":true,
				"contact_me":true,
				"join_room":true,
				"share_customer":false,
				"oper_resign_customer":true,
				"send_customer_msg":true,
				"edit_welcome_msg":true,
				"view_behavior_data":true,
				"view_room_data":true,
				"send_group_msg":true,
				"room_deduplication":true,
				"rapid_reply":true,
				"onjob_customer_transfer":true,
				"edit_anti_spam_rule":true,
				"export_customer_list":true,
				"export_customer_data":true,
				"export_customer_group_list":true,
				"manage_customer_tag":true
		},
		"range":
		[
			{
				"type":1,
				"userid":"zhangsan"
			},
			{
				"type":2,
				"partyid":1
			}
		]
	}

=head4 参数说明：

	参数	            必须	说明
    access_token	是	调用接口凭证
	parent_id	否	父规则组id
	strategy_name	是	规则组名称
	admin_list	是	规则组管理员userid列表，不可配置超级管理员，每个规则组最多可配置20个负责人
	privilege.view_customer_list	否	查看客户列表，基础权限，不可取消
	privilege.view_customer_data	否	查看客户统计数据，基础权限，不可取消
	privilege.view_room_list	否	查看群聊列表，基础权限，不可取消
	privilege.contact_me	否	可使用联系我，基础权限，不可取消
	privilege.join_room	否	可加入群聊，基础权限，不可取消
	privilege.share_customer	否	允许分享客户给其他成员，默认为true
	privilege.oper_resign_customer	否	允许分配离职成员客户，默认为true
	privilege.oper_resign_group	否	允许分配离职成员客户群，默认为true
	privilege.send_customer_msg	否	允许给企业客户发送消息，默认为true
	privilege.edit_welcome_msg	否	允许配置欢迎语，默认为true
	privilege.view_behavior_data	否	允许查看成员联系客户统计，默认为true
	privilege.view_room_data	否	允许查看群聊数据统计，默认为true
	privilege.send_group_msg	否	允许发送消息到企业的客户群，默认为true
	privilege.room_deduplication	否	允许对企业客户群进行去重，默认为true
	privilege.rapid_reply	否	配置快捷回复，默认为true
	privilege.onjob_customer_transfer	否	转接在职成员的客户，默认为true
	privilege.edit_anti_spam_rule	否	编辑企业成员防骚扰规则，默认为true
	privilege.export_customer_list	否	导出客户列表，默认为true
	privilege.export_customer_data	否	导出成员客户统计，默认为true
	privilege.export_customer_group_list	否	导出客户群列表，默认为true
	privilege.manage_customer_tag	否	配置企业客户标签，默认为true
	range.type	是	规则组的管理范围节点类型 1-成员 2-部门
	range.userid	否	规则组的管理成员id
	range.partyid	否	规则组的管理部门id

单次最多可配置20个管理员和100个管理节点
如果要创建的规则组具有父规则组，则其管理范围必须是父规则组的子集，且将完全继承父规则组的权限配置(privilege将被忽略)
管理组的最大层级为5层
每个管理组的管理范围内最多支持3000个节点

=head4 权限说明：

=head3 RETURN 返回结果：

    {
		"errcode": 0,
		"errmsg": "ok",
		"strategy_id":1
	}

=head4 RETURN 参数说明：

	参数	        说明
    errcode	返回码
	errmsg	对返回码的文本描述内容
	strategy_id	规则组id

=cut

sub create {
    if ( @_ && $_[0] && ref $_[1] eq 'HASH' ) {
        my $access_token = $_[0];
        my $json = $_[1];
        my $ua = LWP::UserAgent->new;
        $ua->timeout(30);
        $ua->env_proxy;

        my $response = $ua->post("https://qyapi.weixin.qq.com/cgi-bin/externalcontact/customer_strategy/create?access_token=$access_token",Content => to_json($json,{allow_nonref=>1}),Content_type =>'application/json');
        if ($response->is_success) {
            return from_json($response->decoded_content,{utf8 => 1, allow_nonref => 1});
        }

    }
    return 0;
}

=head2 edit(access_token, hash);

编辑规则组及其管理范围

=head2 SYNOPSIS

L<https://developer.work.weixin.qq.com/document/path/94883#编辑规则组及其管理范围>

=head3 请求说明：

企业可通过此接口编辑规则组的基本信息和修改客户规则组管理范围。该接口仅支持串行调用，请勿并发修改规则组。

=head4 请求包结构体为：

	{
		"strategy_id":1,
		"strategy_name": "NAME",
		"admin_list":[
			"zhangsan",
			"lisi"
		],
		"privilege":
		{
			"view_customer_list":true,
			"view_customer_data":true,
			"view_room_list":true,
			"contact_me":true,
			"join_room":true,
			"share_customer":false,
			"oper_resign_customer":true,
			"oper_resign_group":true,
			"send_customer_msg":true,
			"edit_welcome_msg":true,
			"view_behavior_data":true,
			"view_room_data":true,
			"send_group_msg":true,
			"room_deduplication":true,
			"rapid_reply":true,
			"onjob_customer_transfer":true,
			"edit_anti_spam_rule":true,
			"export_customer_list":true,
			"export_customer_data":true,
			"export_customer_group_list":true,
			"manage_customer_tag":true
		},
		"range_add":
		[
			{
				"type":1,
				"userid":"zhangsan"
			},
			{
				"type":2,
				"partyid":1
			}
		],
		"range_del":
		[
			{
				"type":1,
				"userid":"lisi"
			},
			{
				"type":2,
				"partyid":2
			}
		]
	}

=head4 参数说明：

	参数	            必须	说明
    access_token	是	调用接口凭证
	strategy_id	是	规则组id
	strategy_name	否	规则组名称
	admin_list	否	管理员列表，如果为空则不对负责人做编辑，如果有则覆盖旧的负责人列表
	privilege	否	权限配置，如果为空则不对权限做编辑，如果有则覆盖旧的权限配置
	range_add.type	否	向管理范围添加的节点类型 1-成员 2-部门
	range_add.userid	否	向管理范围添加成员的userid,仅type为1时有效
	range_add.partyid	否	向管理范围添加部门的partyid，仅type为2时有效
	range_del.type	否	从管理范围删除的节点类型 1-成员 2-部门
	range_del.userid	否	从管理范围删除的成员的userid,仅type为1时有效
	range_del.partyid	否	从管理范围删除的部门的partyid，仅type为2时有效

单次最多可配置20个管理员和100个管理节点
如果规则组具有父管理组则其管理范围必须是父规则组的子集，且将完全继承父规则组的权限配置(privilege将被忽略)

=head4 权限说明：

=head3 RETURN 返回结果：

    {
		"errcode": 0,
		"errmsg": "ok"
	}

=head4 RETURN 参数说明：

	参数	        说明
    errcode	返回码
	errmsg	对返回码的文本描述内容

=cut

sub edit {
    if ( @_ && $_[0] && ref $_[1] eq 'HASH' ) {
        my $access_token = $_[0];
        my $json = $_[1];
        my $ua = LWP::UserAgent->new;
        $ua->timeout(30);
        $ua->env_proxy;

        my $response = $ua->post("https://qyapi.weixin.qq.com/cgi-bin/externalcontact/customer_strategy/edit?access_token=$access_token",Content => to_json($json,{allow_nonref=>1}),Content_type =>'application/json');
        if ($response->is_success) {
            return from_json($response->decoded_content,{utf8 => 1, allow_nonref => 1});
        }

    }
    return 0;
}

=head2 del(access_token, hash);

删除规则组

=head2 SYNOPSIS

L<https://developer.work.weixin.qq.com/document/path/94883#删除规则组>

=head3 请求说明：

企业可通过此接口删除某个规则组。

=head4 请求包结构体为：

    {
		"strategy_id":1
	}

=head4 参数说明：

	参数	            必须	说明
    access_token	是	调用接口凭证
	strategy_id	是	规则组id

=head4 权限说明：

=head3 RETURN 返回结果：

    {
		"errcode": 0,
		"errmsg": "ok"
	}

=head4 RETURN 参数说明：

	参数	        说明
    errcode	返回码
	errmsg	对返回码的文本描述内容

=cut

sub del {
    if ( @_ && $_[0] && ref $_[1] eq 'HASH' ) {
        my $access_token = $_[0];
        my $json = $_[1];
        my $ua = LWP::UserAgent->new;
        $ua->timeout(30);
        $ua->env_proxy;

        my $response = $ua->post("https://qyapi.weixin.qq.com/cgi-bin/externalcontact/customer_strategy/del?access_token=$access_token",Content => to_json($json,{allow_nonref=>1}),Content_type =>'application/json');
        if ($response->is_success) {
            return from_json($response->decoded_content,{utf8 => 1, allow_nonref => 1});
        }

    }
    return 0;
}

1;
__END__
