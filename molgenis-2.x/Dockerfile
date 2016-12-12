#
# Fetch from Docker Hub
#
FROM tomcat:8.5-jre8-alpine
RUN apk update && apk add openssl

#
# Get molgenis code + settings
#
RUN wget http://search.maven.org/remotecontent?filepath=org/molgenis/molgenis-app/2.0.1/molgenis-app-2.0.1.war -O /usr/local/tomcat/webapps/ROOT.war
RUN mkdir /usr/local/tomcat/.molgenis
COPY conf/molgenis-server.properties /usr/local/tomcat/.molgenis/
COPY conf/setenv.sh /usr/local/tomcat/bin/

#
# Fetch database connector.
#
RUN wget https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar -O /usr/local/tomcat/lib/postgresql-9.4.1212.jar
