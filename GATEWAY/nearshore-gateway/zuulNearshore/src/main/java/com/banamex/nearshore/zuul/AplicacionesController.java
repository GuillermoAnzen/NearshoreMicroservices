package com.banamex.nearshore.zuul;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
 
import com.banamex.nearshore.data.zuul.ResultBase;

 
 
@RestController

public class AplicacionesController {

	@Autowired
	StringRedisRepository stringRedisRepository;
	  
	@RequestMapping(value={"/logout"}, method={org.springframework.web.bind.annotation.RequestMethod.POST}, produces={"application/json"})
	public Object logout(@RequestHeader("ApplicationID") String ApplicationID)
	{
		ResultBase r = new ResultBase();
		if (ApplicationID != null){
			this.stringRedisRepository.delete(ApplicationID);
		}
		r.setSuccess(true);
		return r;
	}
	
	
	
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
	 
}