#!/bin/bash -ex 

#cat /etc/systemd/system/cfsvc-energi3.service

# energicore
systemctl stop cfsvc-energi3.service
cd /var/lib/energi3/
wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/3.0.7/energi3-3.0.7-linux-amd64.tgz
tar -xzvf energi3-3.0.7-linux-amd64.tgz
rm -rf energi3-3.0.7-linux-amd64.tgz
mv energi3-3.0.7-linux-amd64 energicore3-3.0.7
ln -sfn /var/lib/energi3/energicore3-3.0.7/bin bin
ls -all
/var/lib/energi3/bin/energi3 version

# chaindata
#ls -all
rm -rf /var/lib/energi3/.energicore3/energi3/chaindata/*
cd /var/lib/energi3/
wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/chaindata/mainnet/gen3-chaindata.tar.gz
tar -xzvf gen3-chaindata.tar.gz
rm gen3-chaindata.tar.gz
chown -R energi3:energi3 /var/lib/energi3/.energicore3/energi3/chaindata/

# preimages
cd /var/lib/energi3/bin
rm pre*
wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/chaindata/mainnet/preimages.rlp
./energi3 import-preimages preimages.rlp

systemctl daemon-reload
systemctl restart cfsvc-energi3.service

echo "For logs: journalctl -u cfsvc-energi3.service -ef"
