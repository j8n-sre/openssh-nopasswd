FROM centos:7.9

RUN yum -y update

RUN yum -y install perl \
	openssh-server openssh-clients \
	telnet nc wget net-tools bind-utils tcpdump 

RUN mkdir /var/run/sshd \
	&& ssh-keygen -A 

COPY squid.pem /etc/pki/ca-trust/source/anchors/squid.pem
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub
COPY config /root/.ssh/config

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
