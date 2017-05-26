package mx.com.banamex.microservicio.tdc.base.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.circuitbreaker.EnableCircuitBreaker;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.cloud.netflix.feign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
@ComponentScan("mx.*") 
@EnableCircuitBreaker
@EnableEurekaClient
public class MicroServicioBaseDatosMainApplication {

	public static void main(String[] args) {

		SpringApplication.run(MicroServicioBaseDatosMainApplication.class, args);

	}
}
