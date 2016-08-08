FROM jpetazzo/squid-in-a-can
MAINTAINER SMIDevOps
RUN apt-get update -y
RUN apt-get install -y vim
RUN apt-get install -y less
RUN mkdir -p /var/lib/squid3/session
RUN chown -R proxy:proxy /var/lib/squid3
RUN chmod -R 777 /var/lib/squid3
COPY squid.conf /etc/squid3/squid.conf
COPY splash.html /usr/share/squid3/errors/templates/splash.html
