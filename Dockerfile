FROM centos:centos6

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6
RUN yum -y install openssh-server
RUN yum -y install net-tools vim-enhanced wget openssh-clients nfs-utils screen yum-utils ntp tar unzip
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config


RUN chkconfig  iptables off

RUN ntpdate pool.ntp.org

RUN echo "service ntpd start" >> ~/.bashrc
RUN echo "service rsyslog start" >> ~/.bashrc
RUN echo "service crond start" >> ~/.bashrc
RUN mkdir /usr/axway
COPY  Axway.zip /usr/axway/
RUN chmod 755 /usr/axway/Axway.zip
RUN unzip /usr/axway/Axway.zip && \
    rm /usr/axway/Axway.zip
