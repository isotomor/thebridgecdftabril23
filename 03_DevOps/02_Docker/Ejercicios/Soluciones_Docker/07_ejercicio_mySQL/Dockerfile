# creariamos primero un directorio:
# mkdir mysql-pxb
# cd mysql-pxb

FROM mysql:5.6

LABEl 

ENV PACKAGE percona-xtrabackup-23
 
RUN apt-get update && apt-get install -y wget
 
RUN wget https://repo.percona.com/apt/percona-release_0.1-3.jessie_all.deb && \
    dpkg -i percona-release_0.1-3.jessie_all.deb && \
    apt-get update && \
    apt-get install -y $PACKAGE
 
RUN mkdir -p /backup/xtrabackups
 
VOLUME ["/backup/xtrabackup"]