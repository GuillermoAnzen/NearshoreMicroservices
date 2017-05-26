package com.banamex.nearshore.zuul;

import com.banamex.nearshore.data.zuul.ResultBase;
import com.banamex.nearshore.zuul.util.Utils;
import com.netflix.util.Pair;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StreamUtils;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author Spencer Gibb
 */
public class AddResponseHeaderFilter extends ZuulFilter {
	private final Logger log = LoggerFactory.getLogger(AddResponseHeaderFilter.class);
	@Autowired
	private StringRedisRepository redisRepository;
	
	
	public String filterType() {
		 
		
		return "post";
	}

	public int filterOrder() {
		log.info("filterOrder...");
	
		
		
		return 1;
	}

	public boolean shouldFilter() {
		log.info("shouldFilter...");
		
	 
		return true;
	}

	public Object run() {
	
		
		RequestContext context = RequestContext.getCurrentContext();
		HttpServletRequest request = context.getRequest();
		String AuthorizationH = request.getHeader("Authorization");
		String path = (String) context.get("requestURI");
		
		log.info(String.format("%s request to %s", request.getMethod(), request.getRequestURL().toString()));
		log.info("path:"+path);
		log.info("Authorization:"+AuthorizationH);
		
		if(!path.contains("/login")){
			 if(AuthorizationH!=null){
					
					String datosUser = redisRepository.getBy(AuthorizationH);
					if(datosUser!=null){
						HashMap<String , Object> user = (HashMap<String, Object>) Utils.getMapObject(datosUser);
						//verificar los permisos, con respecto al path
						
						redisRepository.addTime(AuthorizationH,datosUser, 60*15);
						
					}else{
						 log.info("user is null"); 
						noAutorizado(context); 
					}
					
			 }else{
				 log.info("AuthorizationH is null"); 
				 noAutorizado(context);
			 }
	 
		}else{
			autorizado(context);
		 
		}
		 
		
		return null;
	}
	
 
	private void noAutorizado(RequestContext context ){
		 ResultBase retorno = new ResultBase();
			
		 retorno.setSuccess(false);
		 retorno.setMensaje("Unauthorized");
		
		 InputStream stream = context.getResponseDataStream();
		String body = Utils.getJson(retorno);				
		try {
			 context.setResponseDataStream(new ByteArrayInputStream(body.getBytes("UTF-8")));	
			 List<Pair<String, String>> headers = context.getZuulResponseHeaders();
			 headers.add(new Pair("Content-Type", "application/json"));
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	private void autorizado(RequestContext context ){
		 ResultBase retorno = new ResultBase();
			
		 retorno.setSuccess(true);
		 String Authorization = Utils.getCodeId(); 
		 
		try {
			
			InputStream stream = context.getResponseDataStream();
			String body = StreamUtils.copyToString(stream, Charset.forName("UTF-8"));
			context.setResponseBody(body);

			 List<Pair<String, String>> headers = context.getZuulResponseHeaders();
			 headers.add(new Pair("Authorization",Authorization));
			 redisRepository.addTime(Authorization,body, 60*15);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
