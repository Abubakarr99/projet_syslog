FROM debian
RUN apt update && apt install rsyslog ssh rsync rsyslog-gnutls supervisor keepalived -y 
# Copy keepalived configuration into correct place
COPY keepalived.conf /etc/keepalived/
WORKDIR /etc/
RUN mkdir -p /etc/rsyslogTLS

# copy of rsyslog certs
COPY ./cacert.pem /etc/rsyslogTLS/cacert.pem
COPY ./server.pem /etc/rsyslogTLS/server.pem
COPY ./server.key /etc/rsyslogTLS/server.key

# configuration of logrotate
COPY logrotate_sa /etc/logrotate.d/logrotate_sa
COPY logrotate_sl /etc/logrotate.d/logrotate_sl

RUN echo "y\n" | HOSTNAME=`hostname` ssh-keygen -t rsa -C "$HOSTNAME" -f "$HOME/.ssh/id_rsa" -P ""
# configuration of rsyslog
RUN echo '$ModLoad imudp \n\
$UDPServerRun 514 \n\
$UDPServerRun 601 \n\
$ModLoad imtcp \n\
$DefaultNetstreamDriver gtls \n\
$InputTCPServerStreamDriverMode 1  # run driver in TLS-only mode \n\
$InputTCPServerStreamDriverAuthMode x509/name \n\
$DefaultNetstreamDriverCAFile /etc/rsyslogTLS/cacert.pem \n\
$DefaultNetstreamDriverCertFile /etc/rsyslogTLS/server.pem \n\
$DefaultNetstreamDriverKeyFile /etc/rsyslogTLS/server.key \n\
$InputTCPServerRun 514 \n\
$template remote-incoming-logs,"/var/log/remote/%HOSTNAME%/%PROGRAMNAME%.log" \n\
*.* ?remote-incoming-logs \n\
& ~ ' > /etc/rsyslog.conf
# supervisor base configuration
# the keepalive service create a vip between SD and SP
ADD keepalived-supervisord.conf /etc/supervisor.conf
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
EXPOSE 80/tcp
EXPOSE 514/udp
EXPOSE 601/tcp
EXPOSE 22/tcp
