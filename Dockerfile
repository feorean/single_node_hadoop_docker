
FROM ubuntu:latest

WORKDIR /home

RUN apt update 
RUN apt -y install software-properties-common 

RUN apt -y --allow-unauthenticated install  openjdk-8-jdk
RUN update-java-alternatives -s java-1.8.0-openjdk-amd64

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre/


#Copy hadoop
COPY hadoop-2.8.2.tar.gz /usr/local/
WORKDIR /usr/local/
RUN tar -xf hadoop-2.8.2.tar.gz
RUN rm hadoop-2.8.2.tar.gz
RUN ln -s ./hadoop-2.8.2 hadoop

ENV PATH="/usr/local/hadoop/bin:${PATH}"

RUN apt -y install  ssh
RUN apt -y install openssh-server

RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 0600 ~/.ssh/authorized_keys

COPY hadoop-env.sh /usr/local/hadoop/etc/hadoop/
COPY hdfs-site.xml /usr/local/hadoop/etc/hadoop/
COPY core-site.xml /usr/local/hadoop/etc/hadoop/
#Configure map reduce for YARN
COPY mapred-site.xml /usr/local/hadoop/etc/hadoop/
COPY yarn-site.xml /usr/local/hadoop/etc/hadoop/

WORKDIR /bin/

#Bypass interactive prompt
RUN echo "Host *"  >>/root/.ssh/config
RUN echo "StrictHostKeyChecking no" >> /root/.ssh/config

ADD bootstrap.sh /bin/
RUN chmod +x bootstrap.sh

CMD ["/bin/bootstrap.sh"]


RUN mkdir -p /tmp/hadoop-root/dfs/name
RUN /usr/local/hadoop/bin/hdfs namenode -format

EXPOSE 50020 50090 50070 50010 50075 8020 8030 8031 8032 8033 8040 8042 49707 22 8088 9870 9000

EXPOSE 38767



