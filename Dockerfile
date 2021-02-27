FROM tomcat:8.0-alpine

LABEL maintainer=”sibia53@gmail.com”

ADD build/libs/hello-world-servlet.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["./bin/catalina.sh", "run"]
