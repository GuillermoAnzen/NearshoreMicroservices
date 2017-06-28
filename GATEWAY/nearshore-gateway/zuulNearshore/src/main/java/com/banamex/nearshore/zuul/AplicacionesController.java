package com.banamex.nearshore.zuul;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
 
import com.banamex.nearshore.data.zuul.ResultBase;
import com.banamex.nearshore.zuul.util.Utils;

 
 
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
	
	@RequestMapping(value={"/getRedisVariables"}, method = {RequestMethod.POST}, produces = {"application/json"})
	public Object getVariablesRedis(@RequestBody String applicationID){
		Object proveedor = null;
		HashMap<String, Object> result = new HashMap<String, Object>();
		if (applicationID != null){
			String datosUser = this.stringRedisRepository.getBy(applicationID);
			
			HashMap<String, Object> user = (HashMap)Utils.getMapObject(datosUser);
			
			List<HashMap<String, Object>> data = (List)user.get("data");
			proveedor = ((HashMap)data.get(0)).get("idProvedor");
			//proveedor = data.get("idProvedor");
			String hola = "";
			//result.put("prov", proveedor);
			/*List<HashMap<String, String>> dataList = (List<HashMap<String, String>>) 
			
			if (dataList.isEmpty()) {
				throw new UsernameNotFoundException("Username not found.");
			}
			
			HashMap<String, String> userDetailsMap = dataList.get(0);
			
			String email = userDetailsMap.get("Email");
			String password = userDetailsMap.get("Clave");
			String role = userDetailsMap.get("Descripcion");*/
		}
		return proveedor;
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