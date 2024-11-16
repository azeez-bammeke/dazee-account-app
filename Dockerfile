FROM eclipse-temurin:21-jre
LABEL maintainer="webnet.com"

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

COPY target/accounts-0.0.1-SNAPSHOT.jar /accounts-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/accounts-0.0.1-SNAPSHOT.jar"]

#Docker build command
#docker build . -t abammeke/accounts:0-0-1-snapshot