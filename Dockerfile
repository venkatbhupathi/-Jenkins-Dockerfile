FROM Ubuntu:latest
# MAINTAINER AsianCloud
USER root


RUN apt-get update

RUN apt-get install openjdk-8-jre -y
RUN echo "JAVA_HOME=usr/" >> ~/.bashrc

# Tomcat 
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.62/bin/apache-tomcat-9.0.62.tar.gz /tmp
RUN cd /tmp && tar -xvzf apache-tomcat-9.0.62.tar.gz
RUN cd /tmp && mv apache-tomcat-9.0.62 /opt/tomcat
COPY .webapp.war /opt/tomcat/webapps
RUN mkdir /var/log/jenkins

# Jenkins
ADD https://get.jenkins.io/war-stable/2.332.3/jenkins.war /opt/apache-tomcat-9.0.62/webapps
CMD ["/opt/apache-tomcat-9.0.62/bin/catalina.sh","run"]
EXPOSE 8080

#COPY plugins.txt /usr/share/jenkins/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
