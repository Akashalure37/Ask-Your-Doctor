FROM openjdk:8

MAINTAINER Akash <akashalure37@gmail.com>

COPY target/askYourDoctor.jar  /usr/app/

WORKDIR /usr/app/

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "askYourDoctor.jar"]
