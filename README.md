# Advanced IPv6 DDNS

一个通过查询 odhcpd IPv6 地址分配来为局域网内**每一个**设备都进行DDNS的脚本

Lookup odhcp IPv6 lease and DDNS for **every single** device in your network.

在 OpenWRT 18.06 上测试通过

Working on OpenWRT 18.06.

### 使用方法

编辑 settings.txt

Edit settings.txt

```
DDNSServiceProvider DNSPOD.sh
DDNSServiceToken1 DNSPOD的ID
DDNSServiceToken2 DNSPOD的Token
DDNSDomain DNSPOD的域名ID
DUID 设备的DUID 子域名地址 DNSPOD的记录ID 2001:db8::1
DUID YourDeviceDUID SubDomain RecordID 2001:db8::1
```
先把上面的参数填好，然后依照格式添加多个 DUID 项即可 

Fill up the arguments then add DUID items following the above format.

2001:db8::1 可以是任何不重复的内容，这一列是用来保存记录避免重复更新的，请保证新增的DUID项中该列唯一

Make sure 2001:db8::1 in each DUID item are unique.

然后把他使用 crontab 定时执行即可（请自行百度）

Then make it run regularly using crontab. (Google it)

目前支持DNSPOD作为DNS提供商，只要遵循以下参数顺序，你也可以添加你自己的DNS提供商支持，把它放到providers文件夹然后修改DDNSServiceProvider对应的文件名即可

Now only supports https://www.dnspod.cn/ as DDNS provider, you can add your custom provider support accroding to the format below. Put your script into `providers` and modify DDNSServiceProvider argument.

`providers/$DDNSServiceProvider $DDNSServiceToken1 $DDNSServiceToken2 $DDNSDomain $RecordID $SubDomain $Value`
