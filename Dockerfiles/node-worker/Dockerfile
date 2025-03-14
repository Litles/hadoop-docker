FROM hadoop-base:3.3.6

USER root

# ----------------- Container Service -------------------
ADD init.sh /init.sh
RUN chmod a+x /init.sh

#EXPOSE 8042

CMD ["/usr/sbin/sshd", "-D"]
