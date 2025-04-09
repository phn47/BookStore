FROM openjdk:11-jdk-slim
WORKDIR /app
COPY target/Know_Sphere-1.0.jar app.jar
EXPOSE 9090
ENV SPRING_PROFILES_ACTIVE=prod
ENV TZ=Asia/Ho_Chi_Minh
ENV JAVA_TOOL_OPTIONS="-XX:+UseContainerSupport -Xmx512m -Xms256m"
CMD ["java", "-jar", "app.jar"]