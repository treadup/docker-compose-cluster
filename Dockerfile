FROM ubuntu:19.04

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
# RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN mkdir /root/.ssh

# So that we can log in
COPY id_rsa_cluster.pub /root/.ssh/authorized_keys

# So that we can verify who we are
COPY id_rsa_cluster /root/.ssh/id_rsa
COPY id_rsa_cluster.pub /root/.ssh/id_rsa.pub

# So that we know who the server is
# Once you have connected to the bastion server run the scan_servers.sh command
# to generate the known_hosts file.
COPY scan_servers.sh /root/scan_servers.sh

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
