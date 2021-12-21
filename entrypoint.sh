#!/bin/bash
set -o xtrace

# 통신
#echo "export http_proxy=\"http://172.22.30.28:3128\"" >> /root/.bash_profile 
#echo "export https_proxy=\"https://172.22.30.28:3128\"" >> /root/.bash_profile
#source /root/.bash_profile

# sshd 구동
#set -e
chmod 600 -R /root/.ssh/id_rsa
echo '>>> TUNING UP SSH CLIENT...'
echo 'root:admin' |chpasswd
mkdir -p /var/run/sshd && sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
	
# SSH login fix. Otherwise user is kicked off after login
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
echo "export VISIBLE=now" >> /etc/profile
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

echo '>>> STARTING SSH SERVER...'
/usr/sbin/sshd -D 2>/dev/null &

while true; do
	echo "hello centos"
	sleep 60
done
