package mx.com.banamex.microservicio.tdc.base.modelo;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;

import mx.com.banamex.microservicio.tdc.base.commons.ConstantesMensajes;
import mx.com.banamex.microservicio.tdc.base.commons.RequestWrapper;
import mx.com.banamex.microservicio.tdc.base.commons.ResultBase;
import mx.com.banamex.microservicio.tdc.base.dao.DAOMain;
import mx.com.banamex.microservicio.tdc.base.commons.Data;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;

@Service
public class ServicioBD {
	
	private final Logger log = LoggerFactory.getLogger(ServicioBD.class);
	
	@Autowired
	DAOMain dao;
	
	//@HystrixCommand(fallbackMethod = "failGetResultBase")
	public ResultBase getResultBase(RequestWrapper datos) throws SQLException, ParseException{
		//Tipo indica si se trata de una consulta 1:(update, insert, remove) o 2:(select), si regresa o no valores
		int tipo = Integer.parseInt(String.valueOf(datos.getTipoQuery()));
		String sql = String.valueOf(datos.getSql());
		ArrayList<Data> data = new ArrayList<Data>();
		data = datos.getData();
		if(data==null){
			data = new ArrayList<Data>();
		}
		if(tipo == 1){
			return dao.executeTypeUpdate(sql, data);
		}
		if(tipo == 2){
			return dao.executeTypeQuery(sql, data);
		}
		return new ResultBase(false,"Tipo Consulta",null,ConstantesMensajes.ERROR_DATOS_INCORRECTOS,"Tipo de consulta equivocada");
	}
	public ResultBase failGetResultBase(RequestWrapper datos, Throwable e) {
		log.error("Error mcDBMain Hystrix:"+e.getMessage());
		return new ResultBase(false, "Drop Service", null, ConstantesMensajes.ERROR_CONEXION_BASE_DATOS, e.getMessage());
	}
}
