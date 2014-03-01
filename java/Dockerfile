FROM ubuntu
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get install python-software-properties software-properties-common -y
RUN apt-add-repository ppa:webupd8team/java -y
RUN apt-get update -y
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install oracle-java7-installer -y
RUN echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle" >> /etc/environment
RUN . /etc/environment
