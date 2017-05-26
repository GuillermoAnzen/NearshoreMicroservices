package mx.com.banamex.microservicio.tdc.base.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.transaction.Transactional;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;

import mx.com.banamex.microservicio.tdc.base.commons.ConstantesMensajes;
import mx.com.banamex.microservicio.tdc.base.commons.Data;
import mx.com.banamex.microservicio.tdc.base.commons.ResultBase;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
@Transactional
public class DAOMain {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	private final Logger log = LoggerFactory.getLogger(DAOMain.class);
	
	public ResultBase executeTypeUpdate(String sql, ArrayList<Data> data){
		int rowsAffected=0;
		Connection con=null;
		PreparedStatement preparedStatement=null;
		int x=0;
		try {
			con = jdbcTemplate.getDataSource().getConnection();
			preparedStatement = con.prepareStatement(sql);
			for(x=0; x<data.size(); x++){
				try {
					preparedStatement = setData(preparedStatement, data.get(x).getType(), data.get(x).getValue(), data.get(x).getIndex());
				} catch (ParseException e) {
					log.error("ErrorCoversion:" + e.getLocalizedMessage());
					return new ResultBase(false,"TIPO DATO INCORRECTO ERROR CONVERSION, INDEX:" + (x+1) + "-TIPO-" + data.get(x).getType() + "-VALOR-" + data.get(x).getValue(),null,ConstantesMensajes.ERROR_CONVERSION_DATO, e.getMessage());	
				}catch(NumberFormatException e){					
					log.error("ErrorConversion:" + e.getLocalizedMessage());
					return new ResultBase(false,"TIPO DATO INCORRECTO ERROR CONVERSION, INDEX:" + (x+1) + "-TIPO-" + data.get(x).getType() + "-VALOR-" + data.get(x).getValue(),null,ConstantesMensajes.ERROR_CONVERSION_DATO, e.getMessage());	
				}
				if(preparedStatement==null){
					log.error("[Index:"+(x+1)+"|-Tipo:"+data.get(x).getType()+"|Dato:"+data.get(x).getValue()+"] No Soportado");
					return new ResultBase(false,"[INDEX:"+(x+1)+"-|-DATO:"+data.get(x).getValue()+"-|-TIPO:"+data.get(x).getType()+"] NOSOPORTADO",null,ConstantesMensajes.ERROR_DATOS_INCORRECTOS,"TipoDato No soportado");
				}
			}
			long timeInit = System.currentTimeMillis();
			rowsAffected = preparedStatement.executeUpdate();
			con.close();
			preparedStatement.close();
			log.info("Time DataBase:"+(System.currentTimeMillis()-timeInit) + "ms");
			log.debug("ResultadoQuery:" +rowsAffected);
			if(rowsAffected==0){				
				log.info("Consulta realizada con exito, pero no obtuvo resultado");
				return new ResultBase(true,"CONSULTA OK PERO SIN RESULTADO",new ArrayList<HashMap<String, Object>>(),ConstantesMensajes.OK,"");
			}
		} catch (SQLException e) {
			if(rowsAffected==0){
				log.error("ErrorSQL, posiblemente en el campo de un query:" + e.getLocalizedMessage());
			}else{
				log.error("ErrorSQL:" + e.getLocalizedMessage());
			}
			return new ResultBase(false,"SQL_EXCEPTION",null,ConstantesMensajes.ERROR_SQL_EXCEPTION, e.getMessage());
		}finally{
			if(preparedStatement!=null){
				preparedStatement=null;
			}
			if(con!=null){
				try {
					con.close();
					con=null;
				} catch (SQLException e) {
					return new ResultBase(false,"SQL_EXCEPTION",null,ConstantesMensajes.ERROR_SQL_EXCEPTION, e.getMessage());
				}
			}
		}

		return new ResultBase(true,"OK",rowsAffected,ConstantesMensajes.OK,"");
	}
	
	public ResultBase executeTypeQuery(String sql, ArrayList<Data> data){
		
		ResultSet rs=null;
		Connection con=null;
		PreparedStatement preparedStatement=null;
		List<HashMap<String, Object>> resultTotal = new ArrayList<HashMap<String, Object>>(); 
		HashMap<String,Object> resultSimple = new HashMap<String,Object>();
		try {
			con = jdbcTemplate.getDataSource().getConnection();
			preparedStatement = con.prepareStatement(sql);
			for(int x=0; x<data.size();x++){
				try {
					preparedStatement = setData(preparedStatement, data.get(x).getType(), data.get(x).getValue(), data.get(x).getIndex());
				} catch (ParseException e) {
					log.error("ErrorConversion:" + e.getLocalizedMessage());
					return new ResultBase(false,"TIPO DATO INCORRECTO KEY, KEYDATO:" + (x+1) + ":TIPO:" + data.get(x).getType() + ":VALOR:" + data.get(x).getValue(),null,ConstantesMensajes.ERROR_CONVERSION_DATO, e.getMessage());		
				}catch(NumberFormatException e){					
					log.error("ErrorConversion:" + e.getLocalizedMessage());
					return new ResultBase(false,"TIPO DATO INCORRECTO KEY, KEYDATO:" + (x+1) + ":TIPO:" + data.get(x).getType() + ":VALOR:" + data.get(x).getValue(),null,ConstantesMensajes.ERROR_CONVERSION_DATO, e.getMessage());	
				}
				if(preparedStatement==null){
					log.error("[Index:"+(x+1)+"|-Tipo:"+data.get(x).getType()+"|Dato:"+data.get(x).getValue()+"] No Soportado");
					return new ResultBase(false,"[INDEX:"+(x+1)+"-|-DATO:"+data.get(x).getValue()+"-|-TIPO:"+data.get(x).getType()+"] NOSOPORTADO",null,ConstantesMensajes.ERROR_DATOS_INCORRECTOS,"TipoDato No soportado");
				}
			}			
			long timeInit = System.currentTimeMillis();
			rs = preparedStatement.executeQuery();			
			log.info("Time DataBase:"+(System.currentTimeMillis()-timeInit) + "ms");
			ResultSetMetaData md = rs.getMetaData();
			int columns = md.getColumnCount();
			while (rs.next()) {
				resultSimple = new HashMap<String,Object>();
				for(int i=1; i<=columns; i++){    
					resultSimple.put(md.getColumnLabel(i), getData(rs, md.getColumnType(i), i));					 
				}
				resultTotal.add(resultSimple);
			}
			con.close();
			preparedStatement.close();
			if(resultTotal.isEmpty()){
				log.info("Consulta:"+sql+":Sin Resultado");
				return new ResultBase(true,"CONSULTA OK PERO SIN RESULTADO",new ArrayList<HashMap<String, Object>>(),ConstantesMensajes.OK,"");		
			}
			return new ResultBase(true,"OK",resultTotal,ConstantesMensajes.OK,"");			
		} catch (SQLException e) {
			log.error("Error " + e.getLocalizedMessage());
			rs=null;
			return new ResultBase(false,"SQL_EXCEPTION",null,ConstantesMensajes.ERROR_SQL_EXCEPTION,e.getMessage());
		}finally{
			if(preparedStatement!=null){
				preparedStatement=null;
			}
			if(con!=null){
				try {
					con.close();
					con=null;
				} catch (SQLException e) {
					return new ResultBase(false,"SQL_EXCEPTION",null,ConstantesMensajes.ERROR_SQL_EXCEPTION, e.getMessage());
				}
			}
		}
	}
	
	public Object getData(ResultSet rs, int typeData, int index) throws SQLException{

		//String o Blob o Clob o NClob o Char o NChar
		if(
			   java.sql.Types.VARCHAR == typeData 
			|| java.sql.Types.LONGNVARCHAR == typeData 
			|| java.sql.Types.NVARCHAR == typeData 
			|| java.sql.Types.BLOB == typeData
			|| java.sql.Types.CLOB == typeData 
			|| java.sql.Types.NCLOB == typeData
			|| java.sql.Types.NCHAR == typeData
			|| java.sql.Types.CHAR == typeData
		)
		{
			return rs.getString(index);
		}
		//int
		if(java.sql.Types.INTEGER == typeData)
		{
			return rs.getInt(index);
		}
		//long
		if(java.sql.Types.BIGINT == typeData){
			return rs.getLong(index);
		}
		//BigDecimal
		if(java.sql.Types.NUMERIC == typeData || java.sql.Types.DECIMAL == typeData){
			return rs.getBigDecimal(index);
		}
		//Boolean
		if(java.sql.Types.BOOLEAN == typeData){
			return rs.getBoolean(index);
		}
		//Double o Float
		if(java.sql.Types.DOUBLE == typeData || java.sql.Types.FLOAT == typeData){
			return rs.getDouble(index);
		}
		//Float
		if(java.sql.Types.REAL == typeData){
			return rs.getFloat(index);
		}
		//Short
		if(java.sql.Types.SMALLINT == typeData){
			return rs.getShort(index);
		}
		//Object
		if(java.sql.Types.JAVA_OBJECT == typeData || java.sql.Types.OTHER == typeData){
			return rs.getObject(index);
		}
		//Byte
		if(java.sql.Types.TINYINT == typeData){
			return rs.getByte(index);
		}
		//Time
		if(java.sql.Types.TIME == typeData || java.sql.Types.TIME_WITH_TIMEZONE == typeData){
			return rs.getTime(index);
		}
		//Timestamp
		if(java.sql.Types.TIMESTAMP == typeData || java.sql.Types.TIMESTAMP_WITH_TIMEZONE == typeData){
			return rs.getTimestamp(index);
		}		
		//Date
		if(java.sql.Types.DATE == typeData){
			return rs.getDate(index);
		}
		//Bytes y otros
		return rs.getString(index);
	}
	
	public PreparedStatement setData(PreparedStatement ps, String tipo, Object ob,  int indice) throws SQLException, java.text.ParseException, java.lang.NumberFormatException{

		if(tipo.toUpperCase().equals("STRING")){
			ps.setString(indice, String.valueOf(ob));
			return ps;
		}
		if(tipo.toUpperCase().equals("INT")){
			ps.setInt(indice, Integer.parseInt(String.valueOf(ob)));
			return ps;
		}
		if(tipo.toUpperCase().equals("LONG")){
			ps.setLong(indice, Long.parseLong(String.valueOf(ob)));
			return ps;
		}
		if(tipo.toUpperCase().equals("BIGDECIMAL")){
			ps.setBigDecimal(indice, new BigDecimal(String.valueOf(ob)));
			return ps;
		}
		if(tipo.toUpperCase().equals("BOOLEAN")){
			ps.setBoolean(indice, Boolean.parseBoolean(String.valueOf(ob)));
			return ps;
		}
		if(tipo.toUpperCase().equals("BYTES")){
			byte[] b = String.valueOf(ob).getBytes();
			ps.setBytes(indice, b);
			return ps;
		}		
		if(tipo.toUpperCase().equals("DOUBLE")){
			ps.setDouble(indice, Double.parseDouble(String.valueOf(ob)));
			return ps;
		}
		if(tipo.toUpperCase().equals("FLOAT")){
			ps.setFloat(indice, Float.parseFloat(String.valueOf(ob)));
			return ps;
		}
		if(tipo.toUpperCase().equals("SHORT")){
			ps.setShort(indice, Short.valueOf(String.valueOf(ob)));
			return ps;
		}
		if(tipo.toUpperCase().equals("BLOB")){
			/*
			Blob bl;
			String byt = String.valueOf(ob);
			bl  =  new SerialBlob(byt.getBytes());
			ps.setBlob(indice, bl);
			return ps;
			*/
			ps.setString(indice, String.valueOf(ob));
			return ps;
		}
		if(tipo.toUpperCase().equals("CLOB")){
			/*
			Clob cl;
			String byt = String.valueOf(ob);
			cl  =  new SerialClob(byt.toCharArray());
			ps.setClob(indice, cl);
			return ps;
			*/
			ps.setString(indice, String.valueOf(ob));
			return ps;
		}
		if(tipo.toUpperCase().equals("OBJECT")){
			ps.setObject(indice, ob);
			return ps;
		}
		if(tipo.toUpperCase().equals("BYTE")){
			ps.setByte(indice, new Byte(String.valueOf(ob)));
			return ps;
		}
		if(tipo.toUpperCase().equals("TIME")){
			ps.setTime(indice, java.sql.Time.valueOf(String.valueOf(ob)));
			return ps;
		}
		
		if(tipo.toUpperCase().equals("TIMESTAMP")){
			ps.setTimestamp(indice,  new Timestamp((Long.parseLong(String.valueOf(ob)))));
			return ps;
		}		
		
		if(tipo.toUpperCase().equals("DATE")){
			if(String.valueOf(ob).contains("-")){
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");//Poner en properties eso
		        java.util.Date date = formatter.parse(String.valueOf(ob));
				//System.out.println(date);
				//System.out.println(formatter.format(date));
				ps.setDate(indice, new java.sql.Date(date.getTime()));
				return ps;
			}
			ps.setDate(indice, new Date(Long.valueOf(String.valueOf(ob))));
			return ps;
		}
		
		return null;
		
	}
}
