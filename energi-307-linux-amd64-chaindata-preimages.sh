#!/bin/bash -ex 

#cat /etc/systemd/system/cfsvc-energi3.service

# # energicore
systemctl stop cfsvc-energi3.service
cd /var/lib/energi3/
wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/3.0.7/energi3-3.0.7-linux-amd64.tgz
tar -xzvf energi3-3.0.7-linux-amd64.tgz
rm -rf energi3-3.0.7-linux-amd64.tgz
mv energi3-3.0.7-linux-amd64 energicore3-3.0.7
ln -sfn /var/lib/energi3/energicore3-3.0.7/bin bin
# ls -all


cd /var/lib/energi3/
/var/lib/energi3/bin/energi3 version

# chaindata
#ls -all
rm -rf /var/lib/energi3/.energicore3/energi3/chaindata/*
cd /var/lib/energi3/.energicore3/energi3/
#wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/chaindata/mainnet/gen3-chaindata.tar.gz
#unpacking directly in chaindata
wget https://s3-us-west-2.amazonaws.com/download.energi.software/chaindata_block_325160_0x4cb544153c88b0568fbe8b9ea15d53361db5a5033b64133e0f4aaa8118413839.tar.gz
tar -xzvf chaindata_block_325160_0x4cb544153c88b0568fbe8b9ea15d53361db5a5033b64133e0f4aaa8118413839.tar.gz
#tar -xzvf gen3-chaindata.tar.gz
#rm -f gen3-chaindata.tar.gz
chown -R energi3:energi3 /var/lib/energi3/.energicore3/energi3/chaindata/
# wget --quiet -c \"${chaindata_url}\" -O - | sudo tar -C \"/home/energi/.energicore3/energi3\" -xz

# preimages
cd /var/lib/energi3/bin
rm -f pre*
wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/chaindata/mainnet/preimages.rlp
./energi3 import-preimages preimages.rlp

# echo 'admin.addPeer("enode://b6c1c639fceecdfa0c986663647c63255f949cb32c8502e0564b983508c346b8b7bc093490759ef1982ba635d7da2b57d94342ecd862df1ef085abb9bd042e2b@13.57.51.172:39797")' | energi3-console

# echo 'admin.peers'| energi3-console

#systemctl daemon-reload
#systemctl restart cfsvc-energi3.service

echo "For logs: journalctl -u cfsvc-energi3.service -ef"
