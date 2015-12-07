[1mdiff --git a/rebuild.sh b/rebuild.sh[m
[1mindex fb1a56e..d5212ad 100755[m
[1m--- a/rebuild.sh[m
[1m+++ b/rebuild.sh[m
[36m@@ -1,6 +1,7 @@[m
 #!/bin/bash[m
 [m
[31m-docker build -t="wurstmeister/storm" storm[m
[31m-docker build -t="wurstmeister/storm-nimbus" storm-nimbus[m
[31m-docker build -t="wurstmeister/storm-supervisor" storm-supervisor[m
[31m-docker build -t="wurstmeister/storm-ui" storm-ui[m
[32m+[m[32mdocker build -t="gchiam/storm" storm[m
[32m+[m[32mdocker build -t="gchiam/storm:0.10.0" storm[m
[32m+[m[32mdocker build -t="gchiam/storm-nimbus" storm-nimbus[m
[32m+[m[32mdocker build -t="gchiam/storm-supervisor" storm-supervisor[m
[32m+[m[32mdocker build -t="gchiam/storm-ui" storm-ui[m
[1mdiff --git a/storm-nimbus/Dockerfile b/storm-nimbus/Dockerfile[m
[1mindex 5051bea..61be7dd 100644[m
[1m--- a/storm-nimbus/Dockerfile[m
[1m+++ b/storm-nimbus/Dockerfile[m
[36m@@ -1,11 +1,13 @@[m
[31m-FROM wurstmeister/storm:0.9.4[m
[31m-MAINTAINER Wurstmeister[m
[32m+[m[32mFROM gchiam/storm:0.10.4[m
 [m
[31m-RUN /usr/bin/config-supervisord.sh nimbus [m
[32m+[m[32mMAINTAINER Gordoon Chiam <gordon.chiam@gmail.com>[m
[32m+[m
[32m+[m[32mRUN /usr/bin/config-supervisord.sh nimbus[m
 RUN /usr/bin/config-supervisord.sh drpc[m
 [m
 EXPOSE 6627[m
 EXPOSE 3772[m
 EXPOSE 3773[m
[32m+[m
 ADD start-supervisor.sh /usr/bin/start-supervisor.sh[m
 CMD /usr/bin/start-supervisor.sh[m
[1mdiff --git a/storm-supervisor/Dockerfile b/storm-supervisor/Dockerfile[m
[1mindex eea1593..c6a221b 100644[m
[1m--- a/storm-supervisor/Dockerfile[m
[1m+++ b/storm-supervisor/Dockerfile[m
[36m@@ -1,5 +1,5 @@[m
[31m-FROM wurstmeister/storm:0.9.4[m
[31m-MAINTAINER Wurstmeister[m
[32m+[m[32mFROM gchiam/storm:0.10.0[m
[32m+[m[32mMAINTAINER Gordoon Chiam <gordon.chiam@gmail.com>[m
 [m
 EXPOSE 6700[m
 EXPOSE 6701[m
[36m@@ -7,10 +7,15 @@[m [mEXPOSE 6702[m
 EXPOSE 6703[m
 EXPOSE 8000[m
 [m
[32m+[m[32mRUN apt-get intsall python-pip[m
[32m+[m[32mRUN apk --update add \[m
[32m+[m[32m    python \[m
[32m+[m[32m    python-dev \[m
[32m+[m[32m    py-pip[m
[32m+[m
[32m+[m[32mRUN pip install -U pip[m
[32m+[m[32mRUN pip install virtualenv[m
[32m+[m
 RUN /usr/bin/config-supervisord.sh supervisor[m
 RUN /usr/bin/config-supervisord.sh logviewer[m
 CMD /usr/bin/start-supervisor.sh[m
[31m-[m
[31m-[m
[31m-[m
[31m-[m
[1mdiff --git a/storm-ui/Dockerfile b/storm-ui/Dockerfile[m
[1mindex 5a7eae1..3864b0a 100644[m
[1m--- a/storm-ui/Dockerfile[m
[1m+++ b/storm-ui/Dockerfile[m
[36m@@ -1,11 +1,8 @@[m
[31m-FROM wurstmeister/storm:0.9.4[m
[31m-MAINTAINER Wurstmeister[m
[32m+[m[32mFROM gchiam/storm:0.10.0[m
[32m+[m
[32m+[m[32mMAINTAINER Gordoon Chiam <gordon.chiam@gmail.com>[m
[32m+[m
 RUN /usr/bin/config-supervisord.sh ui[m
 [m
 EXPOSE 8080[m
 CMD /usr/bin/start-supervisor.sh[m
[31m-[m
[31m-[m
[31m-[m
[31m-[m
[31m-[m
[1mdiff --git a/storm/Dockerfile b/storm/Dockerfile[m
[1mindex 21b088d..1783af8 100644[m
[1m--- a/storm/Dockerfile[m
[1m+++ b/storm/Dockerfile[m
[36m@@ -1,17 +1,19 @@[m
[31m-FROM wurstmeister/base[m
[32m+[m[32mFROM gchiam/openjdk:8[m
 [m
[31m-MAINTAINER Wurstmeister [m
[32m+[m[32mMAINTAINER Gordoon Chiam <gordon.chiam@gmail.com>[m
 [m
[31m-RUN wget -q -O - http://mirrors.sonic.net/apache/storm/apache-storm-0.9.4/apache-storm-0.9.4.tar.gz | tar -xzf - -C /opt[m
[32m+[m[32mRUN apk --update add supervisor[m
 [m
[31m-ENV STORM_HOME /opt/apache-storm-0.9.4[m
[31m-RUN groupadd storm; useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm; chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm[m
[32m+[m[32mRUN wget -q -O - http://www.us.apache.org/dist/storm/apache-storm-0.10.0/apache-storm-0.10.0.tar.gz | tar -xzf - -C /opt[m
[32m+[m
[32m+[m[32mENV STORM_HOME /opt/apache-storm-0.10.0[m
[32m+[m[32mRUN addgroup storm; adduser -D -G storm -h /home/storm -s /bin/bash storm; chown -R storm:storm $STORM_HOME; mkdir /var/log/storm ; chown -R storm:storm /var/log/storm[m
 [m
 RUN ln -s $STORM_HOME/bin/storm /usr/bin/storm[m
 [m
 ADD storm.yaml $STORM_HOME/conf/storm.yaml[m
 ADD cluster.xml $STORM_HOME/logback/cluster.xml[m
 ADD config-supervisord.sh /usr/bin/config-supervisord.sh[m
[31m-ADD start-supervisor.sh /usr/bin/start-supervisor.sh [m
[32m+[m[32mADD start-supervisor.sh /usr/bin/start-supervisor.sh[m
 [m
[31m-RUN echo [supervisord] | tee -a /etc/supervisor/supervisord.conf ; echo nodaemon=true | tee -a /etc/supervisor/supervisord.conf[m
[32m+[m[32mRUN sed -e "s/;nodaemon=false/nodaemon=true/" -i /etc/supervisord.conf[m
