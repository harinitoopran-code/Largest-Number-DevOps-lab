FROM eclipse-temurin:25-jdk

WORKDIR /app

COPY Largest.java .

RUN javac Largest.java

CMD ["sh", "-c", "printf '10 25 15\\n' | java -cp /app Largest"]