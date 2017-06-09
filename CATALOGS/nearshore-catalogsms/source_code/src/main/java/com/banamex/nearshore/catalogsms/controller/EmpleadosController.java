package com.banamex.nearshore.catalogsms.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.banamex.nearshore.catalogsms.domain.RecursoCiti;
import com.banamex.nearshore.catalogsms.domain.RecursoProveedor;
import com.banamex.nearshore.catalogsms.exception.NearshoreDatabaseMicroserviceException;
import com.banamex.nearshore.catalogsms.pagination.AppsEmployePagination;
import com.banamex.nearshore.catalogsms.pagination.CitiDomainPagination;
import com.banamex.nearshore.catalogsms.pagination.Pagination;
import com.banamex.nearshore.databasems.Data;
import com.banamex.nearshore.databasems.ResultBase;
import com.banamex.nearshore.util.Constants;

@RestController
@RequestMapping("empleados")
public class EmpleadosController {
	
	@Autowired
	DbMicroserviceClient databaseMicroserviceClient;

	/*
	 * GET MANAGER EMPLOYEES 
	 */
	@RequestMapping(value = "/gerentes", method = RequestMethod.GET, produces = "application/json")
	public Object getManagerList(){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "SELECT "
				+ "RC.Soe_Id AS id, "
				+ "concat(RC.Primer_Nombre,' ', RC.Segundo_Nombre,' ',RC.Apellido_Paterno,' ',RC.Apellido_Materno) AS gerente "
				+ "FROM RECURSO_CITI RC "
				+ "INNER JOIN CAT_PUESTOCITI PC "
				+ "ON RC.Id_Puesto = PC.Id WHERE PC.Descripcion like 'gerente' OR PC.Descripcion like 'manager'");
		
		Object resultBase = null;
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		return resultBase;
	}	
	
	/*
	 * GET LEADER EMPLOYEES 
	 */
	@RequestMapping(value = "/lideres", method = RequestMethod.GET, produces = "application/json")
	public Object getLeaderList(){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "SELECT "
				+ "RC.Soe_Id AS id, "
				+ "concat(RC.Primer_Nombre,' ', RC.Segundo_Nombre,' ',RC.Apellido_Paterno,' ',RC.Apellido_Materno) AS lider "
				+ "FROM RECURSO_CITI RC "
				+ "INNER JOIN CAT_PUESTOCITI PC "
				+ "ON RC.Id_Puesto = PC.Id WHERE PC.Descripcion like 'lider'");
		
		Object resultBase = null;
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		return resultBase;
	}
	
	/*
	 * GET ANALIST EMPLOYEES 
	 */
	@RequestMapping(value = "/analistas", method = RequestMethod.GET, produces = "application/json")
	public Object getAnalistList(){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "SELECT "
				+ "RC.Soe_Id AS id, "
				+ "concat(RC.Primer_Nombre,' ', RC.Segundo_Nombre,' ',RC.Apellido_Paterno,' ',RC.Apellido_Materno) AS analista "
				+ "FROM RECURSO_CITI RC "
				+ "INNER JOIN CAT_PUESTOCITI PC "
				+ "ON RC.Id_Puesto = PC.Id "
				+ "WHERE PC.Descripcion like 'analista'");
		
		Object resultBase = null;
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		return resultBase;
	}
	
	/*
	 * GET APLICATION DEVELOPED BY A EMPLOYE PER ID 
	 */
	@RequestMapping(value = "/appsEmpleadoCiti", method = RequestMethod.POST, produces = "application/json")
	public Object retrieveAppsCitiEmploye( @RequestBody AppsEmployePagination pagination ){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = new ArrayList<>();
		Data param01 = new Data();
		Data param02 = new Data();
		Data param03 = new Data();
		
		param01.setIndex(1);
		param01.setType("INT");
		param01.setValue(pagination.getIndex().toString());
		queryParams.add(param01);
		
		param02.setIndex(2);
		param02.setType("INT");
		param02.setValue(pagination.getRows().toString());
		queryParams.add(param02);
		
		param03.setIndex(3);
		param03.setType("STRING");
		param03.setValue(pagination.getSoeId());
		queryParams.add(param03);
		
		requestParams.put("tipoQuery", 2);
		requestParams.put("sql", "call nearshore.paginationAppsCitiEmploye(?, ?, ?)");
		requestParams.put("data", queryParams);
		
		Object resultBase = null;
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		return resultBase;
	}
	
	/*
	 * GET EMPLOYES PER DOMAIN
	 * Endpoint that return a list with citi employes per domain.
	 */
	@RequestMapping(value = "/citiDomainId", method = RequestMethod.POST, produces = "application/json")
	public Object retrieveCitiEmployesDomain(@RequestBody CitiDomainPagination pagination){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		Data queryParam02 = new Data();
		Data queryParam03 = new Data();
		
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(pagination.getIndex().toString());
		queryParams.add(queryParam01);
		
		queryParam02.setIndex(2);
		queryParam02.setType("INT");
		queryParam02.setValue(pagination.getRows().toString());
		queryParams.add(queryParam02);
		
		queryParam03.setIndex(3);
		queryParam03.setType("INT");
		queryParam03.setValue(pagination.getIdDomain().toString());
		queryParams.add(queryParam03);
		
		requestParams.put("tipoQuery", 2);
		requestParams.put("sql", "call nearshore.paginationEmployesDomain(?, ?, ?)");
		requestParams.put("data", queryParams);
		
		Object resultBase = null;
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	/*
	 * LIST OF EMPLOYES VS DOMAIN
	 * Return one list with each domain name and each employe in that domain
	 */
	@RequestMapping(value = "/citiDomain", method = RequestMethod.POST, produces = "application/json")
	public Object retrieveAllCitiEmployesDomain(@RequestBody Pagination pagination){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		Data queryParam02 = new Data();
		
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(pagination.getIndex().toString());
		queryParams.add(queryParam01);
		
		queryParam02.setIndex(2);
		queryParam02.setType("INT");
		queryParam02.setValue(pagination.getRows().toString());
		queryParams.add(queryParam02);

		requestParams.put("tipoQuery", 2);
		requestParams.put("sql", "call nearshore.paginationAllEmployesDomain(?, ?)");
		requestParams.put("data", queryParams);
		
		Object resultBase = null;
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch(Exception e){
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	/*
	 * GET EMPLEADOS(CITI)
	 * Endpoint que devuelve un listado de los empleados de CitiBanamex.
	 */
	@RequestMapping(value = "/citiList", method = RequestMethod.POST, produces = "application/json")
	public Object retrieveAllCitiEmployees(@RequestBody Pagination pagination) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		Data queryParam02 = new Data();
		
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(pagination.getIndex().toString());
		queryParams.add(queryParam01);
		
		queryParam02.setIndex(2);
		queryParam02.setType("INT");
		queryParam02.setValue(pagination.getRows().toString());
		queryParams.add(queryParam02);
		
		requestParams.put("tipoQuery", 2);
		requestParams.put("sql", "call nearshore.paginationCitiEmployes(?, ?)");
		requestParams.put("data", queryParams);
		
		Object resultBase = null;
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		}catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	/*
	 * GET EMPLEADOS(CITI)
	 * Endpoint que obtiene un empleado de citi por su soeid.
	 */
	@RequestMapping(value = "/citi/{soeid}", method = RequestMethod.GET, produces = "application/json")
	public Object retrieveCitiEmployeeById(@PathVariable String soeid) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("STRING");
		queryParam01.setValue(soeid);
		queryParams.add(queryParam01);
		
		requestParams.put("tipoQuery", 2);
		requestParams.put("sql", "SELECT D.Descripcion AS Dominio,"
				+ "RC.Soe_Id,"
				+ "RC.Primer_Nombre,"
				+ "RC.Segundo_Nombre,"
				+ "RC.Apellido_Paterno,"
				+ "RC.Apellido_Materno,"
				+ "RC.Movil,"
				+ "RC.Telefono,"
				+ "RC.Email,"
				+ "RC.Ext,"
				+ "C.Descripcion AS Ciudad,"
				+ "P.Descripcion as Pais "
				+ "FROM CAT_DOMINIO D INNER JOIN RECURSO_CITI RC "
				+ "INNER JOIN CAT_PUESTOCITI PC "
				+ "INNER JOIN CAT_CIUDAD C "
				+ "INNER JOIN CAT_PAIS P "
				+ "WHERE "
				+ "RC.Id_Dominio=D.Id AND "
				+ "PC.Id = RC.Id_Puesto AND "
				+ "RC.Id_Ciudad = C.Id AND "
				+ "P.Id = C.Id_Pais AND "
				+ "RC.Soe_Id = ?");
		requestParams.put("data", queryParams);
		
		Object resultBase = null; 
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	/*
	 * POST EMPLEADOS(CITI)
	 * Endpoint que agreda un empleado a citi.
	 */
	@RequestMapping(value = "/citi", method = RequestMethod.POST, produces = "application/json")
	public Object newCitiEmployee(@RequestBody @Valid RecursoCiti recursoCiti) {
		if(recursoCiti.getSoe_id() == null){
			throw new NearshoreDatabaseMicroserviceException("El campo soe_id no puede ser null");
		}
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = new ArrayList<>();
		queryParams = getCitiEmployeeParamsFormated(recursoCiti);
		
		requestParams.put("tipoQuery", 1);
		requestParams.put("sql", "INSERT INTO "+Constants.RECURSO_CITI+" (Apellido_Paterno, Apellido_Materno, Primer_Nombre, Segundo_Nombre, "
				+ "Id_Dominio, Id_Puesto, Id_Ciudad, Ext, Movil, Telefono, Email, Id_ReportaA, Comentarios, SOE_ID) "
				+ "values(?, ?, ?, ?, "
				+ "?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		requestParams.put("data", queryParams);
		
		Object resultBase = null; 
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}

	/*
	 * PUT EMPLEADOS(CITI)
	 * El endpoint permite la edición de la información de un empleado por su soeid de CitiBanamex existente.
	 */
	@RequestMapping(value = "/citi/{soeid}", method = RequestMethod.PUT, produces = "application/json")
	public Object editCitiEmployee(@PathVariable String soeid, @RequestBody @Valid RecursoCiti recursoCiti) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		List<Data> queryParams = new ArrayList<>();
		
		recursoCiti.setSoe_id(soeid);
		queryParams = getCitiEmployeeParamsFormated(recursoCiti);
		
		requestParams.put("tipoQuery", 1);
		requestParams.put("sql", "UPDATE "+Constants.RECURSO_CITI+" SET "
				+ "Apellido_Paterno = ?, Apellido_Materno = ?, Primer_Nombre = ?, Segundo_Nombre = ?, "
				+ "Id_Dominio = ?, Id_Puesto = ?, Id_Ciudad = ?, Ext = ?, Movil = ?, Telefono = ?, "
				+ "Email = ?, Id_ReportaA = ?, Comentarios = ? "
				+ "WHERE SOE_ID = ?");
		requestParams.put("data", queryParams);
		
		Object resultBase = null; 
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}

	/*
	 * DELETE EMPLEADOS(CITI)
	 * El endpoint permite la eliminación de un empleado por su soeid de CitiBanamex existente.
	 */
	@RequestMapping(value = "/citi/{soeid}", method = RequestMethod.DELETE, produces = "application/json")
	public Object removeCitiEmployee(@PathVariable String soeid) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("STRING");
		queryParam01.setValue(soeid);
		queryParams.add(queryParam01);
		
		requestParams.put("tipoQuery", 1);
		requestParams.put("sql", "DELETE FROM "+Constants.RECURSO_CITI+" WHERE SOE_ID = ?");
		requestParams.put("data", queryParams);
		
		Object resultBase = null; 
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}

	/*
	 * GET EMPLEADOS(PROVEEDORES)
	 * El endpoint devuelve un listado de los empleados de los diferentes proveedores de CitiBanamex.
	 */
	@RequestMapping(value = "/proveedores", method = RequestMethod.GET, produces = "application/json")
	public Object retrieveAllSupplierEmployees() {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		requestParams.put("tipoQuery", 2);
		requestParams.put("sql", "SELECT Id, Id_Proveedor, Clave_Empleado, "
				+ "Apellido_Paterno, Apellido_Materno, Primer_Nombre, Segundo_Nombre, "
				+ "Id_Ciudad, Movil_Personal, Telefono_Particular, Email_Personal, "
				+ "Id_Puesto, Id_Reporta_A, Telefono_Proveedor, Ext_Proveedor, "
				+ "Email_Proveedor, SOE_ID, Ext_Citi, Email_Citi, Comentarios "
				+ "FROM "+Constants.RECURSO_PROVEEDOR);
		
		Object resultBase = null; 
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	/*
	 * GET EMPLEADOS(PROVEEDORES)
	 * Endpoint que obtiene empleados de un proveedor por la clave del empleado.
	 */
	@RequestMapping(value = "/proveedores/{claveEmpleado}", method = RequestMethod.GET, produces = "application/json")
	public Object retrieveSupplierEmployeeById(@PathVariable Integer claveEmpleado) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(claveEmpleado.toString());
		queryParams.add(queryParam01);
		
		requestParams.put("tipoQuery", 2);
		requestParams.put("sql", "SELECT Id, Id_Proveedor, Clave_Empleado, "
				+ "Apellido_Paterno, Apellido_Materno, Primer_Nombre, Segundo_Nombre, "
				+ "Id_Ciudad, Movil_Personal, Telefono_Particular, Email_Personal, "
				+ "Id_Puesto, Id_Reporta_A, Telefono_Proveedor, Ext_Proveedor, "
				+ "Email_Proveedor, SOE_ID, Ext_Citi, Email_Citi, Comentarios "
				+ "FROM "+Constants.RECURSO_PROVEEDOR+" WHERE Clave_Empleado = ?");
		requestParams.put("data", queryParams);
		
		Object resultBase = null; 
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	/*
	 * POST EMPLEADOS(PROVEEDORES)
	 * El endpoint agrega un nuevo empleado a un proveedor especifico.
	 */
	@RequestMapping(value = "/proveedores", method = RequestMethod.POST, produces = "application/json")
	public Object newSupplierEmployee(@RequestBody @Valid RecursoProveedor recursoProveedor) {
		if(recursoProveedor.getClaveEmpleado() == null){
			throw new NearshoreDatabaseMicroserviceException("El campo claveEmpleado no puede ser null");
		}
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = new ArrayList<>();
		queryParams = getSupplierEmployeeParamsFormated(recursoProveedor);
		
		requestParams.put("tipoQuery", 1);
		requestParams.put("sql", "insert into "+Constants.RECURSO_PROVEEDOR+" (Id_Proveedor, "
				+ "Apellido_Paterno, Apellido_Materno, Primer_Nombre, Segundo_Nombre, "
				+ "Id_Ciudad, Movil_Personal, Telefono_Particular, Email_Personal, "
				+ "Id_Puesto, Id_Reporta_A, Telefono_Proveedor, Ext_Proveedor, "
				+ "Email_Proveedor, SOE_ID, Ext_Citi, Email_Citi, Comentarios, Clave_Empleado) "
				+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
		requestParams.put("data", queryParams);
		
		Object resultBase = null; 
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}

	/*
	 * PUT EMPLEADOS(PROVEEDORES)
	 * El endpoint permite la edición de la información de un empleado existente de un proveedor.
	 */
	@RequestMapping(value = "/proveedores/{claveEmpleado}", method = RequestMethod.PUT, produces = "application/json")
	public Object editSupplierEmployee(@PathVariable Integer claveEmpleado, @RequestBody @Valid RecursoProveedor recursoProveedor) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		List<Data> queryParams = new ArrayList<>();
		
		recursoProveedor.setClaveEmpleado(claveEmpleado);
		queryParams = getSupplierEmployeeParamsFormated(recursoProveedor);
		
		requestParams.put("tipoQuery", 1);
		requestParams.put("sql", "UPDATE "+Constants.RECURSO_PROVEEDOR+" SET "
				+ "Id_Proveedor = ?, "
				+ "Apellido_Paterno = ?, Apellido_Materno = ?, Primer_Nombre = ?, Segundo_Nombre = ?, "
				+ "Id_Ciudad = ?, Movil_Personal = ?, Telefono_Particular = ?, Email_Personal = ?, "
				+ "Id_Puesto = ?, Id_Reporta_A = ?, Telefono_Proveedor = ?, Ext_Proveedor = ?, "
				+ "Email_Proveedor = ?, SOE_ID = ?, Ext_Citi = ?, Email_Citi = ?, Comentarios = ? "
				+ "WHERE Clave_Empleado = ?");
		requestParams.put("data", queryParams);
		
		Object resultBase = null; 
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}

	/*
	 * DELETE EMPLEADOS(PROVEEDORES)
	 * El endpoint permite la eliminación de los empleados existentes de un proveedor.
	 */
	@RequestMapping(value = "/proveedores/{claveEmpleado}", method = RequestMethod.DELETE, produces = "application/json")
	public Object removeSupplierEmployee(@PathVariable Integer claveEmpleado) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		
		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(claveEmpleado.toString());
		queryParams.add(queryParam01);
		
		requestParams.put("tipoQuery", 1);
		requestParams.put("sql", "DELETE FROM "+Constants.RECURSO_PROVEEDOR+" WHERE Clave_Empleado = ?");
		requestParams.put("data", queryParams);
		
		Object resultBase = null; 
		try{
			resultBase = databaseMicroserviceClient.getResultQuery(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}
		
		return resultBase;
	}
	
	private List<Data> getSupplierEmployeeParamsFormated(RecursoProveedor recursoProveedor) {
		List<Data> queryParams = new ArrayList<>();
		Data[] qryParamsArr = new Data[19];
		
		qryParamsArr[0] = createDataObj(1, "INT", recursoProveedor.getProveedor().getId());
		qryParamsArr[1] = createDataObj(2, "STRING", recursoProveedor.getApellidoPaterno());
		qryParamsArr[2] = createDataObj(3, "STRING", recursoProveedor.getApellidoMaterno());
		qryParamsArr[3] = createDataObj(4, "STRING", recursoProveedor.getPrimerNombre());
		qryParamsArr[4] = createDataObj(5, "STRING", recursoProveedor.getSegundoNombre());
		qryParamsArr[5] = createDataObj(6, "INT", recursoProveedor.getCiudad() != null ? recursoProveedor.getCiudad().getId() : null);
		qryParamsArr[6] = createDataObj(7, "STRING", recursoProveedor.getMovilPersonal());
		qryParamsArr[7] = createDataObj(8, "STRING", recursoProveedor.getTelefonoParticular());
		qryParamsArr[8] = createDataObj(9, "STRING", recursoProveedor.getEmailPersonal());
		qryParamsArr[9] = createDataObj(10, "INT", recursoProveedor.getPuesto() != null ? recursoProveedor.getPuesto().getId() : null);
		qryParamsArr[10] = createDataObj(11, "INT", recursoProveedor.getIdReportaA());
		qryParamsArr[11] = createDataObj(12, "STRING", recursoProveedor.getTelefonoProveedor());
		qryParamsArr[12] = createDataObj(13, "STRING", recursoProveedor.getExtProveedor());
		qryParamsArr[13] = createDataObj(14, "STRING", recursoProveedor.getEmailProveedor());
		qryParamsArr[14] = createDataObj(15, "STRING", recursoProveedor.getSoe_id());
		qryParamsArr[15] = createDataObj(16, "STRING", recursoProveedor.getExtCiti());
		qryParamsArr[16] = createDataObj(17, "STRING", recursoProveedor.getEmailCiti());
		qryParamsArr[17] = createDataObj(18, "STRING", recursoProveedor.getComentarios());
		qryParamsArr[18] = createDataObj(19, "INT", recursoProveedor.getClaveEmpleado());
		
		for(int i = 0; i < qryParamsArr.length; i++)
			queryParams.add(qryParamsArr[i]);
		
		return queryParams;
	}
	
	private List<Data> getCitiEmployeeParamsFormated(RecursoCiti recursoCiti) {
		List<Data> queryParams = new ArrayList<>();
		Data[] qryParamsArr = new Data[14];
		
		qryParamsArr[0] = createDataObj(14, "STRING", recursoCiti.getSoe_id());
		qryParamsArr[1] = createDataObj(1, "STRING", recursoCiti.getApellidoPaterno());
		qryParamsArr[2] = createDataObj(2, "STRING", recursoCiti.getApellidoMaterno());
		qryParamsArr[3] = createDataObj(3, "STRING", recursoCiti.getPrimerNombre());
		qryParamsArr[4] = createDataObj(4, "STRING", recursoCiti.getSegundoNombre());
		qryParamsArr[5] = createDataObj(5, "INT", recursoCiti.getDominio() != null ? recursoCiti.getDominio().getId() : null);//
		qryParamsArr[6] = createDataObj(6, "INT", recursoCiti.getPuestoCiti() != null ? recursoCiti.getPuestoCiti().getId() : null);//
		qryParamsArr[7] = createDataObj(7, "INT", recursoCiti.getCiudad() != null ? recursoCiti.getCiudad().getId() : null);//
		qryParamsArr[8] = createDataObj(8, "STRING", recursoCiti.getExt());
		qryParamsArr[9] = createDataObj(9, "STRING", recursoCiti.getMovil());
		qryParamsArr[10] = createDataObj(10, "STRING", recursoCiti.getTelefono());
		qryParamsArr[11] = createDataObj(11, "STRING", recursoCiti.getEmail());
		String soeid = recursoCiti.getReportaA()!=null ? recursoCiti.getReportaA().getSoe_id() : null;
		qryParamsArr[12] = createDataObj(12, "STRING", soeid);
		qryParamsArr[13] = createDataObj(13, "STRING", recursoCiti.getComentarios());
		
		for(int i = 0; i < qryParamsArr.length ; i++)
			queryParams.add(qryParamsArr[i]);
		
		return queryParams;
	}
	
	private Data createDataObj(int index, String type, Object value){
		String valorparseado = null;
		if(value == null){
			type = "OBJECT";
		}else{
			if(!value.getClass().getName().equals("java.lang.String")){
				valorparseado = value.toString();
			}else{
				valorparseado = (String) value;
			}
		}
		return new Data(valorparseado, type, index);
	}
	
	@FeignClient(name = "mcTDCdbMain")
	public interface DbMicroserviceClient {
		
		@RequestMapping(value = "/getResultBD", method = RequestMethod.POST, produces = "application/json")
		public ResultBase getResultQuery(@RequestBody HashMap<String, Object> datos);
		
	}

}
