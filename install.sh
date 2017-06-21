#!/bin/sh
echo "------------------------ instalando contenedor redis redis "------------------------
docker stop  redis .
docker rm  redis .
docker run  --name   redis    -d -p 6379:6379 redis
echo "------------------------ instalando contenedor eureka "------------------------
cd /home/ec2-user/portalNearshore/microservicios/eureka
docker stop  eureka .
docker rm  eureka .
docker rmi  image_eureka .
docker build -t image_eureka .
docker run  --name   eureka  -d  -p 8761:8761 image_eureka .
echo "------------------------ instalando contenedor zuul "------------------------
cd /home/ec2-user/portalNearshore/microservicios/zuul
docker stop  zuul .
docker rm  zuul .
docker rmi  image_zuul .
docker build -t image_zuul .
docker run   --link   eureka:hostEureka    --link   phpmyadmin:hostPhpMyadmin	  --name    zuul -d -p 80:8080 image_zuul  . 



echo "------------------------ instalando contenedor mcPremiumOpenSession "------------------------
cd /home/ec2-user/portalNearshore/microservicios/appEjemplo
docker stop  app .
docker rm  app .
docker rmi  image_app.
docker build -t image_app .
docker run    --link   eureka:hostEureka   --link   redis:hostRedis   --name app  -d -p 8013:8013 image_app  .



echo "------------------------ instalando contenedor MainDB "------------------------
cd /home/ec2-user/portalNearshore/microservicios/mcBaseDatos
docker stop  mcdb .
docker rm  mcdb .
docker rmi  image_mcdb.
docker build -t image_mcdb .
docker run    --link   eureka:hostEureka   --link   mysql:hostMysql   --name mcdb  -d -p 1007:1007 image_mcdb  .



echo "------------------------ instalando contenedor DEMO "------------------------
cd /home/ec2-user/portalNearshore/microservicios/DEMO
docker stop  demo .
docker rm  demo .
docker rmi  image_demo.
docker build -t image_demo .
docker run    --link   eureka:hostEureka  --name demo  -d -p 1008:1008 image_demo  .



exec /bin/bash
---------------------------------------



docker run -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=password --volume=/root/docker/mysql/conf.d:/etc/mysql/conf.d -d mysql
docker run -d --link mysql:mysql --name phpmyadmin -e MYSQL_USERNAME=password  -p 9000:80 corbinu/docker-phpmyadmin

docker run  -p 8183:80 --name phpmyadmin  -e MYSQL_HOST=mysqlhost -e NGINX_SERVERNAME=localhost -d docker-phpmyadmin /sbin/my_init --enable-insecure-key

