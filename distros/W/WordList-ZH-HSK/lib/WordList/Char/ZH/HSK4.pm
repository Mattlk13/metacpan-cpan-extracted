package WordList::Char::ZH::HSK4;

our $DATE = '2016-02-04'; # DATE
our $VERSION = '0.01'; # VERSION

use utf8;

use WordList;
our @ISA = qw(WordList);

our %STATS = ("num_words_contains_unicode",447,"num_words",447,"num_words_contains_whitespace",0,"avg_word_len",1,"num_words_contains_nonword_chars",0,"longest_word_len",1,"shortest_word_len",1); # STATS

1;
# ABSTRACT: HSK (level 4 only) characters

=pod

=encoding UTF-8

=head1 NAME

WordList::Char::ZH::HSK4 - HSK (level 4 only) characters

=head1 VERSION

This document describes version 0.01 of WordList::Char::ZH::HSK4 (from Perl distribution WordList-ZH-HSK), released on 2016-02-04.

=head1 SYNOPSIS

 use WordList::Char::ZH::HSK4;

 my $wl = WordList::Char::ZH::HSK4->new;

 # Pick a (or several) random word(s) from the list
 my $word = $wl->pick;
 my @words = $wl->pick(3);

 # Check if a word exists in the list
 if ($wl->word_exists('foo')) { ... }

 # Call a callback for each word
 $wl->each_word(sub { my $word = shift; ... });

 # Get all the words
 my @all_words = $wl->all_words;

=head1 DESCRIPTION

=head1 STATISTICS

 +----------------------------------+-------+
 | key                              | value |
 +----------------------------------+-------+
 | avg_word_len                     | 1     |
 | longest_word_len                 | 1     |
 | num_words                        | 447   |
 | num_words_contains_nonword_chars | 0     |
 | num_words_contains_unicode       | 447   |
 | num_words_contains_whitespace    | 0     |
 | shortest_word_len                | 1     |
 +----------------------------------+-------+

The statistics is available in the C<%STATS> package variable.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/WordList-ZH-HSK>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-WordList-ZH-HSK>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=WordList-ZH-HSK>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<WordList::Char::ZH::HSK>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__DATA__
与
专
丢
严
丰
丽
举
之
乒
乓
乘
乱
争
云
互
亚
交
亲
仅
仍
仔
付
价
任
份
众
优
伙
传
伤
估
低
何
使
例
供
保
俩
修
倍
倒
值
停
偶
傅
傲
允
光
克
免
入
全
具
养
内
况
凉
减
刀
切
划
列
则
判
利
剧
剩
功
励
勇
勺
匙
区
博
占
卫
印
危
即
却
厅
厉
压
厌
厕
厚
原
厨
及
反
取
受
另
台
叶
各
合
否
吸
呀
味
呼
命
咱
咳
咸
售
嗽
困
围
圾
址
坚
垃
基
堵
塑
填
增
士
处
够
失
奋
奖
存
孙
寄
密
富
寒
察
导
封
将
尊
尔
尝
尤
尽
局
展
巧
巾
帅
并
幸
幽
广
序
底
度
座
建
弃
弄
式
引
弹
彩
律
微
忆
志
怀
态
怜
性
恐
恼
悉
悔
惊
惜
愉
慕
懒
戚
戴
户
扔
扬
扮
扰
批
技
折
抬
抱
抽
拉
拒
招
拜
拾
持
挂
指
按
挺
授
掉
排
推
播
擦
支
收
改
效
敢
散
敲
整
断
族
无
既
普
景
暂
暑
暖
术
杂
材
松
林
染
柿
标
格
案
桥
桶
梦
棒
森
棵
植
概
橡
款
歉
止
此
死
母
毕
毛
民
永
汁
汗
江
污
汤
沙
油
泉
泼
洋
洲
活
流
济
浪
海
消
深
温
演
漫
激
烟
烤
烦
熟
父
牌
猜
琴
甚
由
申
疑
登
盐
盒
省
矿
码
研
破
础
硕
确
示
社
祝
禁
福
秀
科
秒
积
程
稍
究
穷
窗
竞
竟
章
童
符
笨
签
管
篇
籍
粗
精
糖
紧
约
纪
线
细
绝
继
续
缺
美
羞
羡
羽
翻
耐
职
联
聘
聚
肚
肤
肥
肯
胳
脏
脱
脾
膊
膏
至
航
艺
苦
获
萄
落
著
葡
虎
虑
袋
袜
观
规
言
警
计
讨
许
论
证
评
译
诚
详
误
谅
谈
谊
象
貌
负
责
败
货
质
购
费
贺
资
赚
赢
赶
趟
距
躺
转
输
辛
辣
连
迷
适
通
逛
速
遍
邀
郊
部
酸
醒
释
量
金
针
钢
钥
键
镜
闹
阅
队
际
降
险
陪
随
页
顺
预
餐
饺
饼
首
骄
验
骗
鸭
麻
默
鼓
龄
