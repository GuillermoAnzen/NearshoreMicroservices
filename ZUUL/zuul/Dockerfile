FROM java:8
EXPOSE 8080
ADD zuul-0.0.1-SNAPSHOT.jar zuul-0.0.1-SNAPSHOT.jar
RUN sed -i 's/=SSLv3,/=/g' "/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/security/java.security"
ENTRYPOINT ["java","-Xmx312m","-Dspring.profiles.active=dev","-jar","zuul-0.0.1-SNAPSHOT.jar"]
	