# ===== STAGE 1: Build the JAR =====
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy pom.xml and prefetch dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy your source and build
COPY src ./src
RUN mvn clean package -DskipTests

# ===== STAGE 2: Run the app =====
FROM eclipse-temurin:17-jdk
WORKDIR /usr/app

# Copy the jar from the build stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
