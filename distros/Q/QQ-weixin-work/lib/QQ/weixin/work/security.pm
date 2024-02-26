package QQ::weixin::work::security;

=encoding utf8

=head1 Name

QQ::weixin::work::security

=head1 DESCRIPTION

安全管理

=cut

use strict;
use base qw(QQ::weixin::work);
use Encode;
use LWP::UserAgent;
use JSON;
use utf8;

our $VERSION = '0.10';
our @EXPORT = qw/ get_file_oper_record /;

=head1 FUNCTION

=head2 get_file_oper_record(access_token, hash);

文件防泄漏
最后更新：2023/11/30

=head2 SYNOPSIS

L<https://developer.work.weixin.qq.com/document/path/98079>

=head3 请求说明：

启用了 “文件防泄漏”的企业可以通过本接口查询文件上传、下载、转发等操作记录。

=head4 请求包结构体为：

	{
		"start_time": 166666666,
		"end_time": 166666667,
		"userid_list": ["zhangsan", "lisi"],
		"operation": {
			"type": 103,
			"source":401
		},
		"cursor":"ngLgjieajgieo",
		"limit":100
	}

=head4 参数说明：

	参数	            必须	说明
    access_token	是	调用接口凭证
    start_time	int	是	开始时间
	end_time	int	是	结束时间，开始时间到结束时间的范围不能超过14天
	userid_list	array	否	需要查询的文件操作者的userid，单次最多可以传100个用户
	operation	object	否	参考Operation结构说明
	cursor	string	否	由企业微信后台返回，第一次调用可不填
	limit	int	否	限制返回的条数，最多设置为1000

=head4 调用说明：

调用的应用需要满足如下的权限：
应用类型	权限要求
自建应用	配置到「文件防泄漏 - 可调用接口的应用」中
代开发应用	暂不支持
第三方应用	暂不支持
注： 从2023年12月1日0点起，不再支持通过系统应用secret调用接口，存量企业暂不受影响 查看详情

已产生的操作记录将永久保存
应用可见范围外用户相关的数据会被过滤掉，不会返回

=head3 RETURN 返回结果：

	{
		"errcode": 0,
		"errmsg": "ok",
		"has_more": true,
		"next_cursor": "gejMjgLjgeigoejg",
		"record_list": [{
			"time": 16666666666,
			"userid": "zhangsan",
			"operation": {
				"type": 101,
				"source": 401
			},
			"file_info": "1234567890.jpg"
		}, {
			"time": 16666666666,
			"external_user":{
				"type":2,
				"name":"xxx",
				"corp_name":"十分科技"
			},
			"operation": {
				"type": 10001
			},
			"file_info": "通过zhangsan的链接下载了1234567890.jpg",
			"applicant_name":"张三"
		},{
			"time": 16666666666,
			"userid":"lisi",
			"operation": {
				"type": 103,
				"source":401
			},
			"file_info": "通过zhangsan的链接下载了1234567890.jpg",
			"device_type":1,
			"device_code":"owM2ovo"
		}]
	}

=head4 RETURN 参数说明：

	参数	        说明
	errcode	int32	错误码
	errmsg	string	错误码说明
	has_more	bool	是否还有更多数据
	next_cursor	string	仅has_more值为true时返回该字段，下一次调用将该值填到cursor字段，以实现分页查询
	record_list.time	int	操作时间
	record_list.userid	string	企业用户账号id，当操作者为企业内部用户时返回该字段
	record_list.external_user	object	企业外部人员账号信息，参考ExternalUser结构说明，当操作者为企业外部用户时返回该结构
	record_list.operation	object	参考Operation结构说明
	record_list.file_info	string	文件操作说明
	record_list.applicant_name	string	当记录操作类型为『通过下载申请』或者『拒绝下载申请』时，该字段表示申请人的名字
	record_list.device_type	int	设备类型
	1-企业可信设备
	2-个人可信设备
	仅当操作类型为『下载』时会返回
	record_list.device_code	string	设备编码。仅当操作类型为『下载』时会返回

=head4 Operation结构说明

	参数	类型	说明
	type	int	操作类型，101：上传；102：新建文件夹；103：下载；104：更新；105：星标；106：移动；107：复制；108：重命名；109：删除；110：恢复；111：彻底删除；112：转发到企业微信；113：通过链接下载；114：获取分享链接；115：修改分享链接；116：关闭分享链接；117：收藏；118：新建文档；119：新建表格；121：打开；124：导出文件；127：添加文件成员；128：修改文件成员权限；129：移除文件成员；130：设置文档水印；131：修改企业内权限；132：修改企业外权限；133：添加快捷入口；134：转发到微信；135：预览；136：权限管理；139：安全设置；140：通过邮件分享；142：离职成员文件转交；10001：通过下载申请；10002：拒绝下载申请；
	source	int	操作来源，在操作类型为“上传”或者“下载”时，可以通过改字段细分操作来源。401：聊天；402：邮件；403：文档；404：微盘；405：日程

=head4 ExternalUser结构说明

	参数	类型	说明
	type	int	用户类型，1：微信用户；2：企业微信用户
	name	string	用户名
	corp_name	string	当用户为企业微信用户时，返回该字段

=cut

sub get_file_oper_record {
    if ( @_ && $_[0] && ref $_[1] eq 'HASH' ) {
        my $access_token = $_[0];
        my $json = $_[1];
        my $ua = LWP::UserAgent->new;
        $ua->timeout(30);
        $ua->env_proxy;

        my $response = $ua->post("https://qyapi.weixin.qq.com/cgi-bin/security/get_file_oper_record?access_token=$access_token",Content => to_json($json,{allow_nonref=>1}),Content_type =>'application/json');
        if ($response->is_success) {
            return from_json($response->decoded_content,{utf8 => 1, allow_nonref => 1});
        }

    }
    return 0;
}

1;
__END__
