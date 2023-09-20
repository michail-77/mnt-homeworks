FROM centos

RUN yum -y update
RUN yum install -y openssh-server
RUN ssh-keygen -A
ADD /etc/ssh/sshd_config /etc/ssh/sshd_config
RUN echo root:netology | chpasswd
CMD /usr/sbin/sshd -D
 
ENV container=docker  
 
COPY container.target /etc/systemd/system/container.target
 
RUN ln -sf /etc/systemd/system/container.target /etc/systemd/system/default.target
 
ENTRYPOINT ["/sbin/init"]
 
CMD ["--log-level=info"]
 
STOPSIGNAL SIGRTMIN+3
