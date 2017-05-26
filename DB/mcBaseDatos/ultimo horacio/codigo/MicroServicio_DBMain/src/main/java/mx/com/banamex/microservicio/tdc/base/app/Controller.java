package mx.com.banamex.microservicio.tdc.base.app;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.http.HttpStatus;

import mx.com.banamex.microservicio.tdc.base.app.AppConfig.MessagesErrors;
import mx.com.banamex.microservicio.tdc.base.commons.ConstantesMensajes;
import mx.com.banamex.microservicio.tdc.base.commons.RequestWrapper;
import mx.com.banamex.microservicio.tdc.base.commons.ResultBase;
import mx.com.banamex.microservicio.tdc.base.commons.Utils;
import mx.com.banamex.microservicio.tdc.base.modelo.ServicioBD;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {
	
	private final Logger log = LoggerFactory.getLogger(Controller.class);
	private long timeInit;
	@Autowired
	ServicioBD service;
	@Autowired
	MessagesErrors messagesErrors;
	
	@RequestMapping(value = "/getResultBD",method = RequestMethod.POST, produces="application/json")
	public Object getResultQuery(@RequestBody @Valid RequestWrapper datos, BindingResult result) throws SQLException, ParseException {
			
		this.timeInit = System.currentTimeMillis();
		log.info("getResultBD");
		log.debug("InformacionRecibida:" + Utils.getJson(datos));
		ResultBase r = new ResultBase();
		if (result.hasErrors()) {
			log.debug("Error en datos de entrada");
			String msg = messagesErrors.getErrores(result).toString().replace("=", " ").replace("}", "").replace("{", "");			
			//msg =  msg.replace("=", " ").replace("}", "").replace("{", "");
			r = new ResultBase(false, msg, null, ConstantesMensajes.ERROR_DATOS_INCORRECTOS,"ExceptionData");
			log.info("Result-mcBDMain:"+Utils.getJson(r));
			log.info("Time mcBDMain:"+(System.currentTimeMillis()-this.timeInit) + "ms");	
			return r;
		} 
		r = service.getResultBase(datos);
		log.info("Result-mcBDMain:"+Utils.getJson(r));
		log.info("Time mcBDMain:"+(System.currentTimeMillis()-this.timeInit) + "ms");	
		pasarGarbageCollector();
		return r;
	}
	
	public void pasarGarbageCollector(){
		 
        Runtime garbage = Runtime.getRuntime();
        //System.out.println("Memoria libre antes de limpieza:"+ garbage.freeMemory());
        garbage.gc();
        //System.out.println("Memoria libre tras la limpieza:"+ garbage.freeMemory());
    }
	
	@ResponseStatus(HttpStatus.OK)
	@ExceptionHandler(Throwable.class)
	@ResponseBody Object handleBadRequest(HttpServletRequest req, Exception ex) {
		 
		ResultBase er;
		this.timeInit=System.currentTimeMillis();
		log.error("Exception-mcBDMain:" + ex.getLocalizedMessage());
		if(ex.getMessage().contains("Could not read document: Unexpected character") || ex.getMessage().contains("Could not read document: Unrecognized token")|| ex.getMessage().contains("Could not read document")){
			er = new ResultBase(false,"Malformed Data",null,ConstantesMensajes.ERROR_DATOS_INCORRECTOS,ex.getLocalizedMessage());
			log.info("Result-mcBDMain:"+Utils.getJson(er));
			log.info("Time mcBDMain:"+(System.currentTimeMillis()-timeInit) + "ms");
			return er;
		}
		if(ex.getMessage().contains("Required request body is missing")){
			er = new ResultBase(false,"Request Missed",null,ConstantesMensajes.ERROR_DATOS_INCOMPLETOS,ex.getMessage());
			log.info("Result-MCBDMain:"+Utils.getJson(er));
			log.info("Time mcBDMain:"+(System.currentTimeMillis()-this.timeInit) + "ms");
			return er;
		}
		if(ex.getMessage().contains("Unable to acquire JDBC Connection")){
			er = new ResultBase(false,"Drop Connection",null,ConstantesMensajes.ERROR_CONEXION_BASE_DATOS,ex.getMessage());
			log.info("Result-MCBDMain:"+Utils.getJson(er));
			log.info("Time mcBDMain:"+(System.currentTimeMillis()-timeInit) + "ms");
			return er;
		}
		if(ex.getMessage().contains("Can not deserialize value of type")){
			er = new ResultBase(false,"Malformed Data",null,ConstantesMensajes.ERROR_DATOS_INCORRECTOS,Utils.parseExpectedValue(ex.getMessage()));
			log.info("Result-mcBDMain:"+Utils.getJson(er));
			log.info("Time mcBDMain:"+(System.currentTimeMillis()-timeInit) + "ms");
			return er;
		}
		er = new ResultBase(false,ex.getMessage(),null,ConstantesMensajes.ERROR_SERVICIO_INTERNO,ex.getMessage());
		log.info("Result-mcBDMain:"+Utils.getJson(er));
		log.info("Time mcBDMain:"+(System.currentTimeMillis()-timeInit) + "ms");
		return er;
	} 
	
}
