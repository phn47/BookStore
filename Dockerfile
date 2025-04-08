# Dockerfile for Know Sphere application
# Use a multi-stage build to reduce the final image size
FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/Know_Sphere-1.0.jar app.jar
EXPOSE 9090
CMD ["java", "-jar", "app.jar"]