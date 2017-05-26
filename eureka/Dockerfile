FROM java:8
EXPOSE 8761
ADD eureka-0.0.1-SNAPSHOT.jar eureka-0.0.1-SNAPSHOT.jar
RUN sed -i 's/=SSLv3,/=/g' "/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security"
ENTRYPOINT ["java","-Xmx312m","-Dspring.profiles.active=dev","-jar","eureka-0.0.1-SNAPSHOT.jar"]
