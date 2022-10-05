FROM debian
RUN apt update && apt install rsyslog rsyslog-gnutls supervisor keepalived -y 
# Copy keepalived configuration into correct place
COPY keepalived.conf /etc/keepalived/
WORKDIR /etc/
RUN mkdir -p /etc/rsyslogTLS
COPY ./cacert.pem /etc/rsyslogTLS/cacert.pem
COPY ./server.pem /etc/rsyslogTLS/server.pem
COPY ./server.key /etc/rsyslogTLS/server.key
RUN echo '$ModLoad imudp \n\
$UDPServerRun 514 \n\
$ModLoad imtcp \n\
$InputTCPServerRun 514 \n\
$template RemoteStore, "/var/log/remote/%$year%/%$Month%/%$Day%/%$Hour%.log" \n\
:source, !isequal, "localhost" -?RemoteStore \n\
:source, isequal, "last" ~ ' > /etc/rsyslog.conf
# supervisor base configuration
ADD keepalived-supervisord.conf /etc/supervisor.conf
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
EXPOSE 80/tcp
EXPOSE 514/udp
EXPOSE 514/tcp

