package com.banamex.nearshore.zuul;

 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
 
import org.springframework.stereotype.Service;
 

import com.banamex.nearshore.data.zuul.Data;
 
import com.banamex.nearshore.data.zuul.ResultBase;

import com.banamex.nearshore.zuul.exception.NearshoreDatabaseMicroserviceException;
import com.banamex.nearshore.zuul.util.Constants;
 
@Service
public class ServiciosExternos {
	 
	@Autowired
	private StringRedisRepository redisRepository;
	 
	
	private static Logger log = LoggerFactory.getLogger(ServiciosExternos.class);
	   
    
	
	public void ponerSession(String key, String dato){
		redisRepository.addTime(key, dato, 60*15);
	}
	
	
	public void quitarSession(String key){
		redisRepository.delete(key);
	}

	
}
