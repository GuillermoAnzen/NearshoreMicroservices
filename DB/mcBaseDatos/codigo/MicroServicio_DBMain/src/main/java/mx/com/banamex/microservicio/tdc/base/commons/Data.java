package mx.com.banamex.microservicio.tdc.base.commons;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

public class Data implements Serializable{
	
	private Object value;
	@NotEmpty
	private String type;
	@NotNull
	private int index;
	public Data(){}
	public Data(String value, String type, int index) {
		super();
		this.value = value;
		this.type = type;
		this.index = index;
	}
	public Object getValue() {
		return value;
	}
	public void setValue(Object value) {
		this.value = value;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	@Override
	public String toString() {
		return "Data [value=" + value + ", type=" + type + ", index=" + index
				+ "]";
	}
}
