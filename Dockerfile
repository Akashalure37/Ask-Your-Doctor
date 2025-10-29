# ===== STAGE 1: Build the JAR =====
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

# ===== STAGE 2: Run the app =====
FROM eclipse-temurin:17-jdk
WORKDIR /usr/app

# Copy the specific JAR from the build stage
COPY --from=build /app/target/Doctor_Patient_App-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
