FROM debian
RUN apt update && apt install rsync  ssh supervisor keepalived -y 
WORKDIR /etc/
RUN mkdir -p /etc/rsyslogTLS


# supervisor base configuration
# the keepalive service create a vip between SD and SP
ADD keepalived-supervisord.conf /etc/supervisor.conf
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
EXPOSE 80/tcp
EXPOSE 514/udp
EXPOSE 601/tcp
EXPOSE 22/tcp
