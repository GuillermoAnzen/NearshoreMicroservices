package com.banamex.nearshore.zuul;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.banamex.nearshore.data.zuul.Data;
 
import com.banamex.nearshore.data.zuul.ResultBase;
import com.banamex.nearshore.zuul.exception.NearshoreDatabaseMicroserviceException;

import com.banamex.nearshore.zuul.util.Constants;
import com.banamex.nearshore.zuul.util.Errors;
import com.banamex.nearshore.zuul.util.Utils;

 
 
@RestController

public class AplicacionesController {

	private final Logger log = LoggerFactory.getLogger(AplicacionesController.class);
	
	@Autowired
	private ServiciosExternos serviciosExternos;
 
/*
	@RequestMapping(value = "/login" ,  method = RequestMethod.POST )
    public Object  login( @RequestBody HashMap<String, String> datos ) { 	
	
		System.out.println("datos:"+Utils.getJson(datos) );
		
		
		ResultBase datoUser = serviciosExternos.callLogin(datos.get("usuario") , datos.get("password"));
		
		System.out.println("datoUser:"+Utils.getJson(datoUser) );
		
		ResultBase retorno = new ResultBase();
		
		List datosConsulta = (List) datoUser.getData();
		
		if(datosConsulta!=null && datosConsulta.size()>0){
			String Authorization = Utils.getCodeId();
			HashMap<String , Object> user = (HashMap<String, Object>) datosConsulta.get(0);
			user.remove("Clave");
			user.put("Authorization", Authorization) ;
			 
			serviciosExternos.ponerSession(Authorization, Utils.getJson(user));
			
			retorno.setSuccess(true);
			retorno.setData(user);
			
		}else{
			retorno.setSuccess(false);
			retorno.setMensaje("Unauthorized");
			
		}
		
		 
		return retorno; 
		
	}
	//redisRepository.addTime("prueba", "hola",5);
	 
	 

	@FeignClient(name = "mcTDCdbMain")
	public interface DatabaseMicroserviceClient {

		@RequestMapping(value = "/getResultBD", method = RequestMethod.POST, produces = "application/json")
		public ResultBase getResultQuery(@RequestBody HashMap<String, Object> datos);

	}
*/
	
	@ResponseStatus(HttpStatus.OK)
	@ExceptionHandler(Throwable.class)
	@ResponseBody Object handleBadRequest(HttpServletRequest req, Exception ex) {
		 
		if(ex.getMessage().contains("Could not read JSON document")){
			log.debug("part");
			return new ResultBase(false,Errors.MalformedJson,"Could not read JSON document");
		}
		
		if(ex.getMessage().contains("Required request part")){
			log.debug("part");
			return new ResultBase(false,Errors.InvalidValueExpected,ex.getMessage());
		}
		
		if(ex.getMessage().contains("Can not deserialize value of type")){
			return new ResultBase(false,Errors.InvalidValueExpected,Utils.parseExpectedValue(ex.getMessage()));
		}
		

		if(ex.getMessage().contains("Required request body is missing")){
			return new ResultBase(false,Errors.InvalidValueExpected,"Required request body");
		}
		
		return new ResultBase(false,Errors.ErrorInSystem, ex.getMessage() );
	
		 
	} 
	
		 
	 
}