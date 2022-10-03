FROM debian
RUN apt update && apt install rsyslog rsyslog-gnutls -y
# Install keepalived on it
RUN apt-get update && apt-get install -y keepalived
# Copy keepalived configuration into correct place
COPY keepalived.conf /etc/keepalived
# Make sure keepalived will run
COPY keepalived-supervisord.conf /opt/docker/etc/supervisor.d
WORKDIR /etc/
RUN mkdir -p /etc/rsyslogTLS
COPY ./cacert.pem /etc/rsyslogTLS/cacert.pem
COPY ./server.pem /etc/rsyslogTLS/server.pem
COPY ./server.key /etc/rsyslogTLS/server.key
RUN echo '$ModLoad imudp \n\
$UDPServerRun 514 \n\
$ModLoad imtcp \n\
$InputTCPServerRun 514 \n\
$DefaultNetstreamDriver gtls \n\
$DefaultNetstreamDriverCAFile /etc/rsyslogTLS/cacert.pem \n\
$DefaultNetstreamDriverCertFile /etc/rsyslogTLS/server.pem \n\
$DefaultNetstreamDriverKeyFile /etc/rsyslogTLS/server.key \n\
$template RemoteStore, "/var/log/remote/%$year%/%$Month%/%$Day%/%$Hour%.log" \n\
:source, !isequal, "localhost" -?RemoteStore \n\
:source, isequal, "last" ~ ' > /etc/rsyslog.conf
ENTRYPOINT ["rsyslogd", "-n"]
