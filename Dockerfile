FROM openjdk:11-jdk
WORKDIR /app
COPY target/BookStore-1.0.jar app.jar
EXPOSE 9090
ENTRYPOINT ["java","-jar","app.jar"]