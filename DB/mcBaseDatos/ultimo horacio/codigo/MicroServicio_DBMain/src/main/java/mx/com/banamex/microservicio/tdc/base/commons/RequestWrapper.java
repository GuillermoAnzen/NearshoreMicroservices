package mx.com.banamex.microservicio.tdc.base.commons;

import java.util.ArrayList;

import javax.validation.Valid;

import org.hibernate.validator.constraints.NotEmpty;

public class RequestWrapper {

	@NotEmpty
	private String tipoQuery;
	@NotEmpty
	private String sql;
	@Valid
	private ArrayList<Data> data = new ArrayList<Data>();
	
	public String getTipoQuery() {
		return tipoQuery;
	}
	public void setTipoQuery(String tipoQuery) {
		this.tipoQuery = tipoQuery;
	}
	public String getSql() {
		return sql;
	}
	public void setSql(String sql) {
		this.sql = sql;
	}
	public ArrayList<Data> getData() {
		return data;
	}
	public void setData(ArrayList<Data> data) {
		this.data = data;
	}	
}
