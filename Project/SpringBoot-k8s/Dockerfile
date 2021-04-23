#Build 1
FROM maven:3.5-jdk-8-alpine as builder
WORKDIR /app
COPY pom.xml ./

COPY src ./src/
RUN mvn clean package install -DskipTests

#Build 2
FROM adoptopenjdk/openjdk8:jdk8u202-b08-alpine-slim
COPY --from=builder /app/target/*.jar  /app.jar

CMD ["java","-jar","/app.jar"]
