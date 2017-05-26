package com.banamex.nearshore.appsms.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.netflix.feign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.banamex.nearshore.appsms.exception.NearshoreDatabaseMicroserviceException;
import com.banamex.nearshore.databasems.Data;
import com.banamex.nearshore.databasems.DatabaseMicroserviceClientService;
import com.banamex.nearshore.databasems.ResultBase;
import com.banamex.nearshore.util.Constants;


@RestController
@RequestMapping("aplicaciones")
public class AplicacionesController {

	@Autowired
	private DatabaseMicroserviceClientService databaseMicroserviceClientService;
	
	/*
	 * Devuelve las aplicaciones por de un dominio en particular 
	*/
	@RequestMapping(value = "/dominio/{idDominio}", method = RequestMethod.GET, produces = "application/json")
	public Object getApplicacionsByIdDomain( @PathVariable Integer idDominio ){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();

		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(idDominio.toString());
		queryParams.add(queryParam01);

		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "SELECT aplic.CSI_ID,aplic.Descripcion_Corta FROM APLICACION aplic INNER JOIN CAT_DOMINIO D WHERE aplic.Id_Dominio = D.Id AND aplic.Id_Dominio = ?");
		requestParams.put("data", queryParams);

		Object resultBase = null;
		try {
			resultBase = databaseMicroserviceClientService.callBase(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}

		return resultBase;
	}
	
	/*
 	*Endpoint que devuelve las aplicaciones por dominio
 	*/
	@RequestMapping(value = "/dominios", method = RequestMethod.GET, produces = "application/json")
	public Object retrieveApplicationsByDomains(){
		HashMap<String, Object> requestParams = new HashMap<String, Object>();
		List<Data> queryParams = new ArrayList<>();
		
		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "SELECT aplic.CSI_ID,aplic.Descripcion_Corta,D.Descripcion as dominio FROM APLICACION aplic INNER JOIN CAT_DOMINIO D WHERE aplic.Id_Dominio = D.Id;");
		requestParams.put("data", queryParams);

		Object resultBase = null;
		try {
			resultBase = databaseMicroserviceClientService.callBase(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}

		return resultBase;
	}
	
	/*
	 * Endpoint que devuelve las aplicaciones por un id de dominio 
	 */
	@RequestMapping(value = "/idAplicacion/{idCsi}", method = RequestMethod.GET, produces = "application/json")
	public Object retrieveApplicationsByDomain(@PathVariable Integer idCsi) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();

		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(idCsi.toString());
		queryParams.add(queryParam01);

		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "SELECT D.Descripcion as dominio,a.Csi_Id,a.Ptb_Id,a.Descripcion_Corta as Descripcion_Corta,a.Descripcion_Larga as descripcionLarga,P.Descripcion as provL1,P2.Descripcion as provL2, P3.Descripcion as provL3, PL1.Descripcion as ptfPrimaria, PL2.Descripcion as ptfSecundaria, PL3.Descripcion as ptfTerciaria, a.Comentarios" +
" FROM" + 
" APLICACION a INNER JOIN CAT_DOMINIO D INNER JOIN CAT_PROVEEDOR P INNER JOIN CAT_PROVEEDOR P2 INNER JOIN CAT_PROVEEDOR P3 INNER JOIN CAT_PLATAFORMA PL1 INNER JOIN CAT_PLATAFORMA PL2 INNER JOIN CAT_PLATAFORMA PL3" +
" WHERE" + 
"(D.Id = a.Id_Dominio AND P.Id = a.Id_L1 AND P2.Id = a.Id_L2 AND P3.Id = a.Id_L3 ANd PL1.Id = a.Id_Plat1 ANd PL2.Id = a.Id_Plat2 AND PL3.Id = a.Id_Plat3 AND a.Csi_Id = ? )");
		requestParams.put("data", queryParams);

		Object resultBase = null;
		try {
			resultBase = databaseMicroserviceClientService.callBase(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}

		return resultBase;
	}

	/*
	 * Endpoint que devuelve aplicaciones por sci_Id de aplicacion y id de dominio
	 */
	@RequestMapping(value = "/{scid}/dominio/{idDom}", method = RequestMethod.GET, produces = "application/json")
	public Object retrieveApplicationsByDomainAndScid(@PathVariable Integer idDom, @PathVariable Integer scid) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();

		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(idDom.toString());
		queryParams.add(queryParam01);
		

		Data queryParam02 = new Data();
		queryParam02.setIndex(2);
		queryParam02.setType("INT");
		queryParam02.setValue(scid.toString());
		queryParams.add(queryParam02);

		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "SELECT aplic.* FROM APLICACION aplic WHERE Id_Dominio = ? and Csi_id = ?");
		requestParams.put("data", queryParams);

		Object resultBase = null;
		try {
			resultBase = databaseMicroserviceClientService.callBase(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}

		return resultBase;
	}

	/*
	 * Miembro que devuelve los proveedores de determinada aplicacion
	 */
	@RequestMapping(value = "/{idAplicacion}/proveedores", method = RequestMethod.GET, produces = "application/json")
	public Object retrieveProviderOfApplication(@PathVariable Integer idAplicacion) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();

		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(idAplicacion.toString());
		queryParams.add(queryParam01);

		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "select distinct cp.id, cp.Descripcion from APLICACION_PROVEEDOR "
				+ "ap join CAT_PROVEEDOR cp on  ap.Id_Proveedor=cp.Id where ap.Csi_Id = ?");
		requestParams.put("data", queryParams);

		Object resultBase = null;
		try {
			resultBase = databaseMicroserviceClientService.callBase(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}

		return resultBase;
	}

	/*
	 * Miembro que devuelve las plataformas que maneja una aplicacion 
	 */
	@RequestMapping(value = "/{idAplicacion}/plataformas", method = RequestMethod.GET, produces = "application/json")
	public Object retrievePlatformsOfApplications(@PathVariable Integer idAplicacion) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();

		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(idAplicacion.toString());
		queryParams.add(queryParam01);

		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "select cp.* from CAT_PLATAFORMA cp join APLICACION ap on "
				+ " (cp.Id=ap.Id_Plat1 or cp.id=ap.Id_Plat2 or cp.Id=ap.Id_Plat3) where ap.Csi_Id = ?");
		requestParams.put("data", queryParams);

		Object resultBase = null;
		try {
			resultBase = databaseMicroserviceClientService.callBase(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}

		return resultBase;
	}

	/*
	 * Miembro que devuelve las aplicaciones relacionadas a determinada plataforma
	 */
	@RequestMapping(value = "/plataformas/{id}", method = RequestMethod.GET, produces = "application/json")
	public Object retrieveApplicationsOfPlatform(@PathVariable Integer id) {
		HashMap<String, Object> requestParams = new HashMap<String, Object>();

		List<Data> queryParams = new ArrayList<>();
		Data queryParam01 = new Data();
		queryParam01.setIndex(1);
		queryParam01.setType("INT");
		queryParam01.setValue(id.toString());
		queryParams.add(queryParam01);

		requestParams.put("tipoQuery", Constants.QUERY_STATEMENT_TYPE);
		requestParams.put("sql", "select ap.* from APLICACION ap join CAT_PLATAFORMA cp on "
				+ " (cp.Id=ap.Id_Plat1 or cp.id=ap.Id_Plat2 or cp.Id=ap.Id_Plat3) where cp.Id = ?");
		requestParams.put("data", queryParams);

		Object resultBase = null;
		try {
			resultBase = databaseMicroserviceClientService.callBase(requestParams);
		} catch (Exception e) {
			throw new NearshoreDatabaseMicroserviceException(e.getMessage());
		}

		return resultBase;
	}
	
	
	


	@FeignClient(name = "mcTDCdbMain")
	public interface DatabaseMicroserviceClient {

		@RequestMapping(value = "/getResultBD", method = RequestMethod.POST, produces = "application/json")
		public ResultBase getResultQuery(@RequestBody HashMap<String, Object> datos);

	}

}
