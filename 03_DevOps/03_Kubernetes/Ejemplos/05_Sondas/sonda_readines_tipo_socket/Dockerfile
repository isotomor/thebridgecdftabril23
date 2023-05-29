FROM centos

MAINTAINER i.sotomoreno@gmail.com

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
# Si no funciona coger la última versión en esta dirección https://apache.rediris.es/tomcat/tomcat-8/
RUN curl -O https://apache.rediris.es/tomcat/tomcat-8/v8.5.88/bin/apache-tomcat-8.5.88.tar.gz
RUN tar xvf apache*.tar.gz
RUN mv apache-tomcat-8.5.88/* /opt/tomcat/.


RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y install java
RUN java -version

WORKDIR /opt/tomcat/webapps
COPY app1.war .
EXPOSE 8080

