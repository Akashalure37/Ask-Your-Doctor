# ===== STAGE 1: Build the JAR =====
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app

# Copy only pom.xml first to cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Now copy your source code and build the app
COPY src ./src
RUN mvn clean package -DskipTests

# ===== STAGE 2: Run the app =====
FROM openjdk:8
WORKDIR /usr/app

# Copy the built jar from the previous stage
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
