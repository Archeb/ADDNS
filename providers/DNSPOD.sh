#!/bin/bash
curl -X POST https://dnsapi.cn/Record.Modify -H "User-Agent: ADDNS" -d "login_token=$1,$2&format=json&domain_id=$3&record_id=$4&sub_domain=$5&value=$6&record_type=AAAA&record_line=%E9%BB%98%E8%AE%A4"
