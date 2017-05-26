package com.banamex.nearshore.zuul.util;

import java.io.IOException;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;


import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import org.apache.commons.lang.RandomStringUtils;

public class Utils {
	
	public static ObjectMapper mapper = new ObjectMapper();
	
	public static String getJson(Object o){
		try {
			return mapper.writeValueAsString(o);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public static Map<String, Object>  getMapObject(String json){
		Map<String, Object> r = null;
		try {
			r =   mapper.readValue(json, new TypeReference<Map<String, Object>>(){});
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return r;
	}
	
	
	public static Map<String, String>  getMapObjectString(String json){
		Map<String, String> r = null;
		try {
			r =   mapper.readValue(json, new TypeReference<Map<String, String>>(){});
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return r;
	}
	 
	
	 
	
	public static XMLGregorianCalendar getXMLGregorianCalendarNow(){
	    GregorianCalendar gregorianCalendar = new GregorianCalendar();
	    DatatypeFactory datatypeFactory;
	    XMLGregorianCalendar now =null;
		try {
			datatypeFactory = DatatypeFactory.newInstance();
			 now = datatypeFactory.newXMLGregorianCalendar(gregorianCalendar);
		} catch (DatatypeConfigurationException e) {
			
		}
	    
	    return now;
	 
	}
	
	public static  String getCodeId() {
		//return RandomStringUtils.random(8, true, true);
		return   UUID.randomUUID().toString();
	}
	
	//se parse el valor de Exception.getMessage para saver el valor esperado.
public static String  parseExpectedValue(String text){
		
		String[] datos = text.split("->");
		String cadenaParametro = datos[ datos.length -1];
		String[] String1 = datos[0].split(":");
		String msg = String1[1].substring(String1[1].indexOf("type"), String1[1].indexOf("from"));
		String msg2 = msg.replace("java", "").replace(".", "").replace("math", "").replace("lang", "").replace("type", "");
		cadenaParametro = cadenaParametro.substring(cadenaParametro.indexOf("["), cadenaParametro.indexOf("]"));
		cadenaParametro = cadenaParametro.replace("[\"", "").replace("\"","");
		return cadenaParametro + " : Was expected" + msg2 + "type";
	}

	public static HashMap<String,String> getKeyValueParse(String cadena, String separador){
		HashMap<String,String> misDatos = new HashMap<String,String>();
	    
		String[] datos = cadena.split(separador);
		for(int i =0 ; i<datos.length-1 ; i++){
			misDatos.put(datos[i],datos[i+1]);
			i++;
		}	
		return misDatos;
	}
	
	
}
