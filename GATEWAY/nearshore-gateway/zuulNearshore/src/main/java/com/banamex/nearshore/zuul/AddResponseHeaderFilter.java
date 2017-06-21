package com.banamex.nearshore.zuul;

import com.banamex.nearshore.data.zuul.ResultBase;
import com.banamex.nearshore.zuul.util.Utils;
import com.netflix.util.Pair;
import com.netflix.zuul.ZuulFilter;
import com.netflix.zuul.context.RequestContext;

import javax.servlet.http.HttpServletRequest;

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
	    String ApplicationIDH = request.getHeader("ApplicationID");
	    String path = (String)context.get("requestURI");
	    
	    this.log.info(String.format("%s request to %s", new Object[] { request.getMethod(), request.getRequestURL().toString() }));
	    this.log.info("path:" + path);
	    this.log.info("ApplicationID:" + ApplicationIDH);
	    if (!path.contains("/login")){
	    	if (ApplicationIDH != null){
		        String datosUser = this.redisRepository.getBy(ApplicationIDH);
		        if (datosUser != null){
		          HashMap<String, Object> user = (HashMap)Utils.getMapObject(datosUser);
		          this.redisRepository.addTime(ApplicationIDH, datosUser, 900);
		        }else{
		        	this.log.info("user is null");
		        	noAutorizado(context);
		        }
	    	}else{
		        this.log.info("ApplicationIDH is null");
		        noAutorizado(context);
	    	}
	    }
	    else{
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
	    try{
	    	context.setResponseDataStream(new ByteArrayInputStream(body.getBytes("UTF-8")));
	    	List<Pair<String, String>> headers = context.getZuulResponseHeaders();
	    	headers.add(new Pair("Content-Type", "application/json"));
	    }catch (IOException e){
	      e.printStackTrace();
	    }
	}
	
	
	private void autorizado(RequestContext context ){
	    ResultBase retorno = new ResultBase();
	    
	    retorno.setSuccess(true);
	    String ApplicationID = Utils.getCodeId();
	    try{
	    	InputStream stream = context.getResponseDataStream();
	    	String body = StreamUtils.copyToString(stream, Charset.forName("UTF-8"));
	      
		      Map<String, Object> body_ = Utils.getMapObject(body);
		      List<HashMap<String, Object>> data = (List)body_.get("data");
		      if (data.size() > 0){
		    	  //((HashMap)data.get(0)).put("ApplicationID", ApplicationID);
		    	  String body_2 = Utils.getJson(body_);
		    	  context.setResponseBody(body_2);
		    	  List<Pair<String, String>> headers = context.getZuulResponseHeaders();
		    	  headers.add(new Pair("ApplicationID", ApplicationID));  
		    	  headers.add(new Pair("access-control-expose-headers", "ApplicationID"));
		      }else{
		    	  context.setResponseBody(body);
		      }
		      this.redisRepository.addTime(ApplicationID, body, 900);
    	}catch (IOException e){
    		e.printStackTrace();
	    }
	}
	
	
}
