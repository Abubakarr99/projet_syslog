FROM debian
RUN apt update && apt install rsyslog rsyslog-gnutls supervisor keepalived -y 
# Copy keepalived configuration into correct place
COPY keepalived.conf /etc/keepalived
WORKDIR /etc/
RUN mkdir -p /etc/rsyslogTLS
COPY ./cacert.pem /etc/rsyslogTLS/cacert.pem
COPY ./server.pem /etc/rsyslogTLS/server.pem
COPY ./server.key /etc/rsyslogTLS/server.key
RUN echo '$ModLoad imudp \n\
$UDPServerRun 514 \n\
$ModLoad imtcp \n\
$InputTCPServerRun 601 \n\
$DefaultNetstreamDriver gtls \n\
$DefaultNetstreamDriverCAFile /etc/rsyslogTLS/cacert.pem \n\
$DefaultNetstreamDriverCertFile /etc/rsyslogTLS/server.pem \n\
$DefaultNetstreamDriverKeyFile /etc/rsyslogTLS/server.key \n\
$template RemoteStore, "/var/log/remote/%$year%/%$Month%/%$Day%/%$Hour%.log" \n\
:source, !isequal, "localhost" -?RemoteStore \n\
:source, isequal, "last" ~ ' > /etc/rsyslog.conf
# supervisor base configuration
COPY keepalived-supervisord.conf /opt/docker/etc/supervisor.d
EXPOSE 80/tcp
EXPOSE 514/udp
EXPOSE 514/tcp

