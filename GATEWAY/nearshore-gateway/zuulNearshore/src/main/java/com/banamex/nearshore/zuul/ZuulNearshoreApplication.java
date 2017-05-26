package com.banamex.nearshore.zuul;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.netflix.feign.EnableFeignClients;
import org.springframework.cloud.netflix.zuul.EnableZuulProxy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.RestController;
 

@SpringBootApplication
@EnableDiscoveryClient
@EnableZuulProxy
@RestController
@ComponentScan("com.banamex.nearshore.*")
@EnableFeignClients
public class ZuulNearshoreApplication {

	public static void main(String[] args) {
		SpringApplication.run(ZuulNearshoreApplication.class, args);
	}
	
	//---- redis ----
	@Bean
	JedisConnectionFactory connectionFactory() {
		return new JedisConnectionFactory();
	}
	
	@Bean
	StringRedisTemplate stringRedisTemplate(RedisConnectionFactory connectionFactory) {
		return new StringRedisTemplate(connectionFactory);
	}

	@Bean
	StringRedisRepository stringRedisRepository(StringRedisTemplate template) {
		return new StringRedisRepository(template);
	}
	//----- filtro ------
	
	@Bean
	public AddResponseHeaderFilter AddResponseHeaderFilter() {
		return new AddResponseHeaderFilter();
	}
	
	//---- bean ------	  
	@Bean
	public ServiciosExternos serviciosExternos() { return new ServiciosExternos(); 	}
	
 
	
	
	
}
