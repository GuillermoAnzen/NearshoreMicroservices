package mx.com.banamex.microservicio.tdc.base.commons;

import java.io.IOException;
import java.util.HashMap;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Utils {
	
	public static ObjectMapper mapper = new ObjectMapper();
	
	public static String getJson(Object o){
		try {
			return mapper.writeValueAsString(o);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return null;
	}
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
	public static HashMap<String,Object> getHM(String s) throws JsonParseException, JsonMappingException, IOException{
		return mapper.readValue(s, HashMap.class);
	}
}