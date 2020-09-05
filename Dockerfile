FROM openjdk:8-alpine
RUN apk --update add wget bash
RUN wget https://ufpr.dl.sourceforge.net/project/pentaho/Pentaho%209.0/server/pentaho-server-ce-9.0.0.0-423.zip
RUN unzip pentaho-server-ce-9.0.0.0-423.zip && \
    mv pentaho-server /opt/ && \
    rm pentaho-server-ce-9.0.0.0-423.zip
COPY ./conector/mysql-connector-java-5.1.47.jar /opt/pentaho-server/tomcat/lib/
RUN rm /opt/pentaho-server/promptuser.sh
RUN echo -e "\ntail -f /opt/pentaho-server/tomcat/logs/catalina.out" >> /opt/pentaho-server/start-pentaho.sh
ENTRYPOINT /opt/pentaho-server/start-pentaho.sh

#CMD ["tail -f /opt/pentaho-server/tomcat/logs/catalina.out"]
