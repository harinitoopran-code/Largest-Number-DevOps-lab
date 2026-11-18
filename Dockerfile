FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY Largest.java .
RUN javac Largest.java
CMD ["java", "Largest"]
