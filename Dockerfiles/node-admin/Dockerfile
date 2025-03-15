FROM python:3.12
#FROM ubuntu:22.04

USER root

# --------------------------------------------------------
# Container Network (SSH)
# --------------------------------------------------------
# 1.Set root password (otherwise no pwd by default)
RUN echo 'root:123456' | chpasswd

# 2.Install SSH application
RUN apt-get update
#RUN apt-get remove -y openssh-client openssh-server
RUN apt-get install -y ssh sshpass vim sudo
RUN chown root:root /
RUN mkdir -p /var/run/sshd
RUN mkdir -p /run/sshd
RUN chmod 0755 /var/run/sshd
RUN chmod 0755 /run/sshd
#RUN sed -i 's/\/var//' /usr/lib/tmpfiles.d/sshd.conf

# 3.Authentication (password and pubkey)
RUN sed -i 's/#UsePAM/UsePAM/' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/PermitRootLogin no/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication/PasswordAuthentication/' /etc/ssh/sshd_config
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/' /etc/ssh/sshd_config
RUN sed -i 's/PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# 4.Something maybe effective
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# ----------------- Container Service -------------------
ADD init.sh /init.sh
ADD run.sh /run.sh
RUN chmod a+x /init.sh /run.sh

#EXPOSE 22
CMD ["/run.sh"]
