#Version:0.0.1
FROM ubuntu:14.04
MAINTAINER snow "xuefeng.zhao@shanchain.com"
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update && \
	apt-get install -y wget xz-utils unzip

RUN mkdir -p /usr/lib/jvm && \ 
	cd /usr/lib/jvm && \
	wget -c http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.tar.gz --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" && \
	tar -xvf jdk-8u112-linux-x64.tar.gz && \
	rm -f jdk-8u112-linux-x64.tar.gz && \
	sudo ln -s jdk1.8.0_112 java-8 && \
	sed -i '$a export JAVA_HOME=/usr/lib/jvm/java-8 \
			export JRE_HOME=${JAVA_HOME}/jre \
			export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib \
			export PATH=${JAVA_HOME}/bin:$PATH' ~/.bashrc
ENV JAVA_HOME /usr/lib/jvm/java-8

RUN cd /opt && \
	wget http://downloads.lightbend.com/scala/2.12.0-RC2/scala-2.12.0-RC2.tgz && \
	tar -zxvf scala-2.12.0-RC2.tgz && \
	rm -f scala-2.12.0-RC2.tgz && \
	sed -i '$a export SCALA_HOME=/opt/scala-2.12.0-RC2 \
			export PATH=${SCALA_HOME}/bin:$PATH' ~/.bashrc
ENV SCALA_HOME /opt/scala-2.12.0-RC2

RUN cd /opt && \
	wget https://downloads.typesafe.com/typesafe-activator/1.3.12/typesafe-activator-1.3.12-minimal.zip && \
	unzip typesafe-activator-1.3.12-minimal.zip && \
	rm -f typesafe-activator-1.3.12-minimal.zip && \
	ln -s /opt/activator-1.3.12-minimal/bin/activator /usr/local/sbin/activator && \
	sed -i '$a export PATH=/usr/local/sbin/activator:$PATH' ~/.bashrc

RUN source ~/.bashrc