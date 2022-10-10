FROM debian

# Install the packages
RUN apt update && apt install rsyslog rsyslog-gnutls supervisor apache2 -y 
WORKDIR /etc/

RUN mkdir -p /etc/rsyslogTLS
RUN mkdir -p /var/log/apache2

# copy certs
#COPY ./cacert.pem /etc/rsyslogTLS/cacert.pem
#COPY ./server.pem /etc/rsyslogTLS/server.pem
#COPY ./server.key /etc/rsyslogTLS/server.key
#COPY index.php /var/www/html

# configure rsyslog
# as a server for SL
RUN echo '$ModLoad imudp \n\
$UDPServerRun 514 \n\
$ModLoad imtcp \n\
$InputTCPServerRun 514 \n\
$template RemoteStore, "/var/log/remote/%$year%/%$Month%/%$Day%/%$Hour%.log" \n\
:source, !isequal, "localhost" -?RemoteStore \n\
:source, isequal, "last" ~ ' > /etc/rsyslog.conf
# as a client for SP & SD
RUN echo '*.* @@10.1.1.22:514' > /etc/rsyslog.d/loghost.conf
# supervisor base configuration
# this allow running of multiple services 
ADD keepalived-supervisord.conf /etc/supervisor.conf
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
EXPOSE 80/tcp
EXPOSE 514/udp
EXPOSE 514/tcp

