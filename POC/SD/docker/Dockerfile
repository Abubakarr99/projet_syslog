FROM debian
RUN apt update && apt install rsyslog rsync ssh rsyslog-gnutls supervisor keepalived -y 
# Copy keepalived configuration into correct place
COPY keepalived.conf /etc/keepalived
WORKDIR /etc/
RUN mkdir -p /etc/rsyslogTLS
# copy of crsyslog certs
#COPY ./cacert.pem /etc/rsyslogTLS/cacert.pem
#COPY ./server.pem /etc/rsyslogTLS/server.pem
#COPY ./server.key /etc/rsyslogTLS/server.key

# configuration of logrotate 
COPY logrotate_sa /etc/logrotate.d/logrotate_sa
COPY logrotate_sl /etc/logrotate.d/logrotate_sl

RUN echo "y\n" | HOSTNAME=`hostname` ssh-keygen -t rsa -C "$HOSTNAME" -f "$HOME/.ssh/id_rsa" -P ""
# configuration of rsyslog
RUN echo '$ModLoad imudp \n\
$UDPServerRun 514 \n\
$ModLoad imtcp \n\
$InputTCPServerRun 601 \n\
$DefaultNetstreamDriver gtls \n\
$InputTCPServerStreamDriverMode 1  # run driver in TLS-only mode \n\
$InputTCPServerStreamDriverAuthMode anon \n\
#$DefaultNetstreamDriverCAFile /etc/rsyslogTLS/cacert.pem \n\
#$DefaultNetstreamDriverCertFile /etc/rsyslogTLS/server.pem \n\
#$DefaultNetstreamDriverKeyFile /etc/rsyslogTLS/server.key \n\
$template remote-incoming-logs,"/var/log/remote/%HOSTNAME%/%PROGRAMNAME%.log" \n\
*.* ?remote-incoming-logs \n\
& ~ ' > /etc/rsyslog.conf

# supervisor base configuration this creates a vip that would be switched between SP --> SD
ADD keepalived-supervisord.conf /etc/supervisor.conf
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
EXPOSE 80/tcp
EXPOSE 514/udp
EXPOSE 601/tcp
EXPOSE 22/tcp
