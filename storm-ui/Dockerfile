FROM gchiam/storm:0.10.0

MAINTAINER Gordoon Chiam <gordon.chiam@gmail.com>

RUN /usr/bin/config-supervisord.sh ui

EXPOSE 8080
CMD /usr/bin/start-supervisor.sh
