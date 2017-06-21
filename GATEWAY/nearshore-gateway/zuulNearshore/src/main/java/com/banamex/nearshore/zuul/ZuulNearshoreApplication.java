package com.banamex.nearshore.zuul;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
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
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CorsFilter;
 

@SpringBootApplication
@EnableDiscoveryClient
@EnableZuulProxy
@RestController
@ComponentScan("com.banamex.nearshore.*")
@EnableFeignClients
public class ZuulNearshoreApplication {
	
	private final Logger log = LoggerFactory.getLogger(ZuulNearshoreApplication.class);
	@Value("${variables.redis.host}")
	private String hostRedis;
	@Value("${variables.redis.port}")
	private Integer portRedis;

	public static void main(String[] args) {
		SpringApplication.run(ZuulNearshoreApplication.class, args);
	}
	
	//---- redis ----
	@Bean
	JedisConnectionFactory connectionFactory() {
		
		JedisConnectionFactory connectionFactory = new JedisConnectionFactory();
	    connectionFactory.setHostName(this.hostRedis);
	    connectionFactory.setPort(this.portRedis.intValue());
	    
	    return connectionFactory;
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
	public CorsFilter corsFilter()
	{
	    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
	    CorsConfiguration config = new CorsConfiguration();
	    config.setAllowCredentials(Boolean.valueOf(true));
	    config.addAllowedOrigin("*");
	    config.addAllowedHeader("*");
	    config.addAllowedMethod("OPTIONS");
	    config.addAllowedMethod("POST");
	    config.addAllowedMethod("GET");
	    config.addAllowedMethod("UPDATE");
	    config.addAllowedMethod("DELETE");
	    config.addAllowedMethod("PUT");
	    source.registerCorsConfiguration("/**", config);
	    
	    return new CorsFilter(source);
	}
	
 
	
	
	
}
