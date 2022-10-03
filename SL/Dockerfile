FROM debian
RUN apt update && apt install rsyslog rsyslog-gnutls -y
WORKDIR /etc/
RUN mkdir -p /etc/rsyslogTLS
COPY ./cacert.pem /etc/rsyslogTLS/cacert.pem
RUN echo '$DefaultNetstreamDriverCAFile /etc/rsyslogTLS/cacert.pem \n\
$DefaultNetstreamDriver gtls \n\
$ActionSendStreamDriverMode 1	# run driver in TLS-only mode \n\
$ActionSendStreamDriverAuthMode anon \n\
*.* @@SP:514' > /etc/rsyslog.d/50-default.conf
ENTRYPOINT ["rsyslogd", "-n"]
