#!/bin/bash
echo ""
echo "==================================="
echo "   Advanced IPv6 DDNS By Archeb"
echo "  https://github.com/Archeb/ADDNS"
echo "==================================="
echo ""
echo "Loading Settings from settings.txt"
if [ ! -f "settings.txt" ]; then
	echo "settings.txt is missing"
	echo "Please visit GitHub repo and recreate one"
	exit
fi
IFS=$'\n'
for line in $(cat settings.txt)
do
	arg0=$(echo $line | cut -f1 -d' ')
	if [ $arg0 != "DUID" ]; then
		eval "$arg0=\"$(echo $line | cut -f2 -d' ')\""
		continue;
	fi
	DUID=$(echo $line | cut -f2 -d' ')
	SubDomain=$(echo $line | cut -f3 -d' ')
	RecordID=$(echo $line | cut -f4 -d' ')
	OldValue=$(echo $line | cut -f5 -d' ')
	for Value in $(cat /tmp/hosts/odhcpd |grep $DUID|cut -f9 -d' '|cut -f1 -d'/')
	do
		if [ $(echo $Value | cut -c1) == '2' ]; then
			echo "DUID $DUID: [$Value]"
			if [ "$Value" == "$OldValue" ]; then
				echo "DUID $DUID No need to update"
				continue;
			fi
			providers/$DDNSServiceProvider $DDNSServiceToken1 $DDNSServiceToken2 $DDNSDomain $RecordID $SubDomain $Value
			sed -i 's/'$OldValue'/'$Value'/g' settings.txt
			break;
		fi
	done
done
