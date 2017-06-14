package com.banamex.nearshore.catalogsms.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.banamex.nearshore.catalogsms.controller.EmpleadosController.DbMicroserviceClient;
import com.banamex.nearshore.catalogsms.domain.EmpleadoProveedor;
import com.banamex.nearshore.catalogsms.exception.NearshoreDatabaseMicroserviceException;
import com.banamex.nearshore.databasems.Data;
import com.banamex.nearshore.util.Constants;
import com.banamex.nearshore.util.Util;

@RestController
@RequestMapping("empProvider")
public class EmpleadoProveedorController {

	@Autowired
	DbMicroserviceClient databaseMicroserviceClient;
	
	@RequestMapping(value = "/employeesVendor/{idVendor}", method = RequestMethod.GET, produces = "application/json")
	public Object getNameEmpleoyeesVendor(@PathVariable Integer idVendor){
		HashMap<String, Object> requestParams = new HashMap<>();
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		Object resultBase = null;
		
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(idVendor.toString());
		queryParams.add(queryParam01);
		
		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "SELECT "
				+ "r.Id AS id,"
				+ "r.Clave_Empleado AS clave,"
				+ "concat(r.Primer_Nombre,' ', r.Segundo_Nombre,' ',r.Apellido_Paterno,' ',r.Apellido_Materno) AS nombre "
				+ "FROM RECURSO_PROVEEDOR r "
				+ "WHERE Id_Proveedor = ?");
		requestParams.put("data", queryParams);
		
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	@RequestMapping(value = "/addEmployee", method = RequestMethod.POST, produces = "application/json")
	public Object setNewEmployeeProvider(@RequestBody EmpleadoProveedor employee){
		HashMap<String, Object> requestParams = new HashMap<>();
		List<Data> queryParams = getQueryParamsEmployee(employee);
		Object resultBase = null;
		
		requestParams.put("tipoQuery", Constants.UPDATE_STATEMENT_TYPE);
		requestParams.put("sql", "INSERT INTO RECURSO_PROVEEDOR ("
				+ "Id_Proveedor, "
				+ "Clave_Empleado, "
				+ "Apellido_Paterno, "
				+ "Apellido_Materno, "
				+ "Primer_Nombre, "
				+ "Segundo_Nombre, "
				+ "LD_celular, "
				+ "Movil_Personal, "
				+ "LD_particular, "
				+ "Telefono_Particular, "
				+ "Email_Personal, "
				+ "Id_Puesto, "
				+ "Id_Ciudad, "
				+ "LD_Proveedor, "
				+ "Telefono_Proveedor, "
				+ "Ext_Proveedor, "
				+ "Email_Proveedor, "
				+ "Soe_Id, "
				+ "LD_Citi, "
				+ "Telefono_citi, "
				+ "Ext_Citi, "
				+ "Email_Citi, "
				+ "Id_Reporta_A, "
				+ "Comentarios) VALUES "
				+ "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		requestParams.put("data", queryParams);
		
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.PUT, produces = "application/json")
	public Object updateEmployeeProvider(@RequestBody EmpleadoProveedor employee){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = getQueryParamsEmployee(employee);
		Data idQueryParam = new Data();
		Object resultBase = null;
		
		idQueryParam.setIndex(25);
		idQueryParam.setType("INT");
		idQueryParam.setValue(employee.getId().toString());
		queryParams.add(idQueryParam);
		
		requestParams.put("tipoQuery", Constants.UPDATE_STATEMENT_TYPE);
		requestParams.put("sql", "UPDATE RECURSO_PROVEEDOR SET "
				+ "Id_Proveedor=?, "
				+ "Clave_Empleado=?, "
				+ "Apellido_Paterno=?, "
				+ "Apellido_Materno=?, "
				+ "Primer_Nombre=?, "
				+ "Segundo_Nombre=?, "
				+ "LD_celular=?, "
				+ "Movil_Personal=?, "
				+ "LD_particular=?, "
				+ "Telefono_Particular=?, "
				+ "Email_Personal=?, "
				+ "Id_Puesto=?, "
				+ "Id_Ciudad=?, "
				+ "LD_Proveedor=?, "
				+ "Telefono_Proveedor=?, "
				+ "Ext_Proveedor=?, "
				+ "Email_Proveedor=?, "
				+ "Soe_Id=?, "
				+ "LD_Citi=?, "
				+ "Telefono_citi=?, "
				+ "Ext_Citi=?, "
				+ "Email_Citi=?, "
				+ "Id_Reporta_A=?, "
				+ "Comentarios=? "
				+ "WHERE Id=?;");
		requestParams.put("data", queryParams);
		
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	private List<Data> getQueryParamsEmployee(EmpleadoProveedor employee) {
		List<Data> queryParams = new ArrayList<Data>();
			
		Data datos []= new Data[24];
			
		datos[0] = Util.createDataObj(employee.getIdProvider(), "INT", 1);
		datos[1] = Util.createDataObj(employee.getIdEmployee() , "INT", 2);
		datos[2] = Util.createDataObj(employee.getFirstLastName() , "STRING", 3);
		datos[3] = Util.createDataObj(employee.getSecondLastName() , "STRING", 4);
		datos[4] = Util.createDataObj(employee.getFirstName() , "STRING", 5);
		datos[5] = Util.createDataObj(employee.getSecondName() , "STRING", 6);
		datos[6] = Util.createDataObj(employee.getLdCelular() , "STRING", 7);
		datos[7] = Util.createDataObj(employee.getPersonalNumber() , "STRING", 8);
		datos[8] = Util.createDataObj(employee.getLdParticular() , "STRING", 9);
		datos[9] = Util.createDataObj(employee.getParticularTelephone() , "STRING", 10);
		datos[10] = Util.createDataObj(employee.getPersonalEmail() , "STRING", 11);
		datos[11] = Util.createDataObj(employee.getPuesto().getId() , "INT", 12);
		datos[12] = Util.createDataObj(employee.getCountry().getId() , "INT", 13);
		datos[13] = Util.createDataObj(employee.getLdProvider() , "STRING", 14);
		datos[14] = Util.createDataObj(employee.getTelephoneProvider() , "STRING", 15);
		datos[15] = Util.createDataObj(employee.getExtension() , "STRING", 16);
		datos[16] = Util.createDataObj(employee.getEmailProvider() , "STRING", 17);
		datos[17] = Util.createDataObj(employee.getSoeId() , "STRING", 18);
		datos[18] = Util.createDataObj(employee.getLdCiti() , "STRING", 19);
		datos[19] = Util.createDataObj(employee.getCitiTelephone() , "STRING", 20);
		datos[20] = Util.createDataObj(employee.getExtCiti() , "STRING", 21);
		datos[21] = Util.createDataObj(employee.getEmailCiti() , "STRING", 22);
		datos[22] = Util.createDataObj(employee.getIdReportaA() , "INT", 23);
		datos[23] = Util.createDataObj(employee.getComments() , "STRING", 24);
			
		for(Data dato : datos) {
			queryParams.add(dato);
		}
					
		return queryParams;
	}
	
	@RequestMapping(value = "/delete/{idEmp}", method = RequestMethod.DELETE, produces = "application/json")
	public Object deleteEmployee(@PathVariable Integer idEmp){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		Object resultBase = null;
		
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(idEmp.toString());
		queryParams.add(queryParam01);
		
		requestParams.put("tipoQuery", Constants.UPDATE_STATEMENT_TYPE);
		requestParams.put("sql", "DELETE FROM RECURSO_PROVEEDOR WHERE Id = ?");
		requestParams.put("data", queryParams);
		
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	@RequestMapping(value = "/get/{idEmp}", method = RequestMethod.GET, produces = "application/json")
	public Object getEmployee(@PathVariable Integer idEmp){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		Object resultBase = null;
		
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(idEmp.toString());
		queryParams.add(queryParam01);
		
		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "SELECT "
				+ "RC.Primer_Nombre, "
				+ "RC.Segundo_Nombre, "
				+ "RC.Apellido_Paterno, "
				+ "RC.Apellido_Materno, "
				+ "RC.Clave_Empleado, "
				+ "RC.Id_Proveedor, "
				+ "CPP.Descripcion AS puesto, "
				+ "CPP.Id AS idPuesto, "
				+ "CP.Descripcion AS pais, "
				+ "CP.Id AS idPais, "
				+ "CC.Descripcion AS ciudad,"
				+ "CC.Id AS idCiudad, "
				+ "RC.LD_celular, "
				+ "RC.Movil_Personal AS celular, "
				+ "RC.LD_particular AS ladaOtro, "
				+ "RC.Telefono_Particular AS telOtro," 
				+ "RC.LD_Proveedor AS ladaProveedor, "
				+ "RC.Telefono_Proveedor, "
				+ "RC.Ext_Proveedor, "
				+ "RC.Email_Proveedor," 
				+ "RC.Soe_Id, "
				+ "RC.Telefono_citi, "
				+ "RC.Ext_Citi, "
				+ "RC.Email_Citi, "
				+ "concat( RPR.Primer_Nombre,' ',RPR.Segundo_Nombre, ' ', RPR.Apellido_Paterno, ' ', RPR.Apellido_Materno ) AS reportaA, "
				+ "RPR.Clave_Empleado AS idReporta, "
				+ "RC.Comentarios "
				+ "FROM "
				+ "RECURSO_PROVEEDOR RC "
				+ "INNER JOIN CAT_PUESTO_PROVEEDOR CPP "
				+ "ON RC.Id_Puesto = CPP.Id "
				+ "INNER JOIN CAT_CIUDAD CC "
				+ "ON RC.Id_Ciudad = CC.Id "
				+ "INNER JOIN CAT_PAIS CP "
				+ "ON CP.Id = CC.Id_Pais " 
				+ "LEFT JOIN RECURSO_PROVEEDOR RPR "
				+ "ON RC.Id_Reporta_A = RPR.Clave_Empleado "
				+ "WHERE RC.Id = ?");
		requestParams.put("data", queryParams);
		
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams); 
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
}
