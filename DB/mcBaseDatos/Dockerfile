FROM java:8
EXPOSE 1007
ADD mcTDCdbMain-0.0.1.jar mcTDCdbMain-0.0.1.jar
ENTRYPOINT ["java","-Xmx312m","-Dspring.profiles.active=dev","-jar","mcTDCdbMain-0.0.1.jar"]
	