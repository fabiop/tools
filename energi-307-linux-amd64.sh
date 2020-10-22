#!/bin/bash -ex 

#cat /etc/systemd/system/cfsvc-energi3.service
#cd /var/lib/energi3/
#ls -all
systemctl stop cfsvc-energi3.service
systemctl status cfsvc-energi3.service
#cd /var/lib/energi3/.energicore3/energi3/chaindata
#ls -all
#rm -rf /var/lib/energi3/.energicore3/energi3/chaindata/*
#ls -all
cd /var/lib/energi3/
wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/3.0.7/energi3-3.0.7-linux-amd64.tgz
tar -xzvf energi3-3.0.7-linux-amd64.tgz
rm -rf energi3-3.0.7-linux-amd64.tgz
mv energi3-3.0.7-linux-amd64 energicore3-3.0.7
ln -sfn /var/lib/energi3/energicore3-3.0.7/bin bin
ls -all
/var/lib/energi3/bin/energi3 version
systemctl restart cfsvc-energi3.service

echo "For logs: journalctl -u cfsvc-energi3.service -ef"
