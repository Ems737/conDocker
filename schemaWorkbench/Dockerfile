FROM openjdk:8-alpine
RUN apk --update add bash
RUN wget https://sourceforge.net/projects/pentaho/files/Pentaho%209.0/client-tools/psw-ce-9.0.0.0-423.zip 
RUN unzip psw-ce-9.0.0.0-423.zip && \
    rm psw-ce-9.0.0.0-423.zip
COPY mysql-connector-java-5.1.47.jar /schema-workbench/drivers/
ENTRYPOINT ./schema-workbench/workbench.sh
