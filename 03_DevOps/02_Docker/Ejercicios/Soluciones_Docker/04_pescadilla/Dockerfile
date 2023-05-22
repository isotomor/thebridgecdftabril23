FROM ubuntu:18.04

RUN apt update
RUN apt install apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
RUN apt update
RUN apt-cache policy docker-ce
RUN apt install docker-ce

# Luego, cuando ya esté creado se debería probar con 
# sudo systemctl status docker