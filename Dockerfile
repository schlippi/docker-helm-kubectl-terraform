FROM maven:3-jdk-8

# first allow HTTPS transport
RUN apt update
RUN apt install apt-transport-https

# add node 8.x repo
COPY nodesource.list /etc/apt/sources.list.d/
RUN curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN apt update

# install pip
RUN apt install -y python3-pip

# install localstack and awscli
RUN pip3 install localstack awscli

# install npm because localstack needs it
RUN apt install npm
