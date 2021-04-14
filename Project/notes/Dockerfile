FROM maven:3.8.1-jdk-11-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml  /workspace
COPY src /workspace/src/
RUN mvn -f pom.xml clean install


FROM adoptopenjdk/openjdk11:jdk-11.0.2.9-slim
ENV PORT 8080
COPY --from=build /workspace/target/*.jar app.jar
ENTRYPOINT exec java $JAVA_OPTS -jar app.jar
