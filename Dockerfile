# VERSION 0.0.1
# 使用默认centos镜像
FROM hub.c.163.com/public/centos:7.2.1511
# 签名
MAINTAINER qhzhang "zh121100@163.com"

# 设置JAVA_HOME环境变量
ENV JAVA_HOME /usr/local/jdk
ENV PATH $JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:CLASSPATH

# 安装jdk、tomcat(我的目录下只放了tomcat与jdk的tar包)，设置root ssh远程登录密码为123456
#ADD ./apache-tomcat-8.5.6.tar.gz /usr/local/
#ADD ./jdk-7u79-linux-x64.tar.gz /usr/local/
ADD ./*.tar.gz /usr/local/
RUN mv /usr/local/jdk1.7.0_79/ /usr/local/jdk && \
    mv /usr/local/apache-tomcat-8.5.6/ /usr/local/tomcat && \
    yum -y install gcc automake autoconf libtool make && \
    echo "root:123456" | chpasswd

# 容器需要开放Tomcat 8080端口
EXPOSE 8080

# 设置Tomcat7初始化运行，SSH终端服务器作为后台运行
ENTRYPOINT /usr/local/tomcat/bin/startup.sh && /usr/sbin/sshd -D
