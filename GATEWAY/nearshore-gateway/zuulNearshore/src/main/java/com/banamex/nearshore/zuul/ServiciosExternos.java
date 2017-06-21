package com.banamex.nearshore.zuul;

import org.springframework.beans.factory.annotation.Autowired;
 
import org.springframework.stereotype.Service;
 
@Service
public class ServiciosExternos {
	 
	@Autowired
	private StringRedisRepository redisRepository;
	
	public void ponerSession(String key, String dato){
		redisRepository.addTime(key, dato, 60*20);
	}
	
	
	public void quitarSession(String key){
		redisRepository.delete(key);
	}

	
}
