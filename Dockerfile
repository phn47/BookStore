FROM openjdk:11-jdk
WORKDIR /app
COPY target/Know_Sphere-1.0.jar app.jar
EXPOSE 9090
ENV SPRING_PROFILES_ACTIVE=prod
ENV JAVA_OPTS="-Xmx512m -Xms256m"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app.jar"]