FROM debian

# Install the packages
RUN apt update && apt install rsyslog ssh rsync  rsyslog-gnutls supervisor apache2 -y 
WORKDIR /etc/

RUN mkdir -p /etc/rsyslogTLS
RUN mkdir -p /var/log/apache2

# copy certs
COPY cacert.pem /etc/rsyslogTLS/cacert.pem
COPY ./SA.pem /etc/rsyslogTLS/SA.pem
COPY ./SA.key /etc/rsyslogTLS/SA.key

COPY index.php /var/www/html

# configuration of rsyslog
RUN echo '$IncludeConfig /etc/rsyslog.d/*.conf \n\
$ModLoad imuxsock.so \n\
$DefaultNetStreamDriver gtls \n\
$DefaultNetStreamDriverCAFile /etc/rsyslogTLS/cacert.pem \n\
$ActionSendStreamDriverMode 1	# run driver in TLS-only mode \n\
$DefaultNetstreamDriverCertFile /etc/rsyslogTLS/SA.pem \n\
$DefaultNetstreamDriverKeyFile /etc/rsyslogTLS/SA.key \n\
$ActionSendStreamDriverAuthMode x509/name \n\
*.info;mail.none;authpriv.none;cron.none      /var/log/messages \n\
authpriv.*                                    /var/log/secure \n\
mail.*                                        /var/log/maillog \n\
cron.*                                        /var/log/cron \n\
uucp,news.crit                                /var/log/spooler \n\
local7.*                                      /var/log/boot.log \n\
*.* @@10.1.1.22:514' > /etc/rsyslog.conf

# configuration of apache2
COPY apache.conf /etc/rsyslog.d/apache.conf
RUN echo "y\n" | HOSTNAME=`hostname` ssh-keygen -t rsa -C "$HOSTNAME" -f "$HOME/.ssh/id_rsa" -P ""
RUN cp /root/.ssh/id_rsa.pub /var/log/id_rsa.pub
# apache conf
RUN echo 'ServerName SA' >> /etc/apache2/apache2.conf
# supervisor base configuration
# this allow running of multiple services 
ADD keepalived-supervisord.conf /etc/supervisor.conf
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
EXPOSE 80/tcp
EXPOSE 514/udp
EXPOSE 514/tcp
EXPOSE 22/tcp
