FROM openjdk:11-jdk-slim
WORKDIR /app
COPY target/Know_Sphere-1.0.jar app.jar
EXPOSE 9090
ENV JAVA_OPTS="-XX:+UseContainerSupport -Xmx512m -Xms256m"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]