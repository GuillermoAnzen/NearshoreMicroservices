package com.banamex.nearshore.zuul;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
@Service
public class StringRedisRepository {

	private final StringRedisTemplate template;

	public StringRedisRepository(StringRedisTemplate template) {
		this.template = template;
	}
	
	public void add(String key, String value) {
		template.opsForValue().set(key, value);
	}

	

	public void addTime(String key, String value,int segundos) {
		template.opsForValue() .set(key, value,segundos,TimeUnit.SECONDS);
	}
	
	public String getBy(String key) {
		return template.opsForValue().get(key);
	}
	
	public Set<String> getKeys(String patternKey) {
		return template.keys(patternKey);
	}
	
	public Set<String> getAllValuesBy(String patternKey) {
		final Set<String> keys = getKeys(patternKey);
		final Set<String> values = new HashSet<String>(keys.size());
		
		for (String key : keys) {
			values.add(getBy(key));
		}
		
		return values;
	}

	public void delete(String key) {
		template.opsForValue().getOperations().delete(key);
	}
}