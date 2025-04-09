FROM openjdk:11-jdk
WORKDIR /app
COPY target/Know_Sphere-1.0.jar app.jar
EXPOSE 9090
ENTRYPOINT ["java","-jar","app.jar","--spring.profiles.active=prod"]