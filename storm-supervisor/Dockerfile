FROM gchiam/storm:0.10.0
MAINTAINER Gordoon Chiam <gordon.chiam@gmail.com>

EXPOSE 6700
EXPOSE 6701
EXPOSE 6702
EXPOSE 6703
EXPOSE 8000

RUN apk --update add \
    curl \
    build-base \
    gcc \
    python \
    python-dev \
    py-pip


RUN pip install -U pip
RUN pip install virtualenv

RUN /usr/bin/config-supervisord.sh supervisor
RUN /usr/bin/config-supervisord.sh logviewer

CMD ["/usr/bin/start-supervisor.sh"]
