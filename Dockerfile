FROM centos

RUN yum -y update
RUN yum install -y openssh-server
RUN ssh-keygen -A
ADD /etc/ssh/sshd_config /etc/ssh/sshd_config
RUN echo root:netology | chpasswd
CMD /usr/sbin/sshd -D
 
