# Stage 1: compile
FROM eclipse-temurin:17-jdk-alpine AS builder
WORKDIR /app
COPY Hello.java .
RUN javac Hello.java

# Stage 2: run (lighter)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/Hello.class .

CMD ["java", "Hello"]