FROM debian

# Install the packages
RUN apt update && apt install rsyslog ssh rsync rsyslog-gnutls supervisor apache2 -y 
WORKDIR /etc/

RUN mkdir -p /etc/rsyslogTLS
RUN mkdir -p /var/log/apache2

# copy certs
#COPY ./cacert.pem /etc/rsyslogTLS/cacert.pem
#COPY ./server.pem /etc/rsyslogTLS/server.pem
#COPY ./server.key /etc/rsyslogTLS/server.key
#COPY index.php /var/www/html


# configuration of rsyslog
RUN echo '$IncludeConfig /etc/rsyslog.d/*.conf \n\
$ModLoad imuxsock.so \n\
*.info;mail.none;authpriv.none;cron.none      /var/log/messages \n\
authpriv.*                                    /var/log/secure \n\
mail.*                                        /var/log/maillog \n\
cron.*                                        /var/log/cron \n\
uucp,news.crit                                /var/log/spooler \n\
local7.*                                      /var/log/boot.log \n\
*.* @@SA:514' > /etc/rsyslog.conf
COPY apache.conf /etc/rsyslog.d/apache.conf
COPY sync_sa /etc/cron.d/sync_sa
# apache conf
RUN echo 'ServerName SL' >> /etc/apache2/apache2.conf
# supervisor base configuration
# this allow running of multiple services 
ADD keepalived-supervisord.conf /etc/supervisor.conf
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
EXPOSE 80/tcp
EXPOSE 514/udp
EXPOSE 601/tcp
EXPOSE 22/tcp

