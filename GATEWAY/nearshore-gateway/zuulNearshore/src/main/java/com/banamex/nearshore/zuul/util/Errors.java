package com.banamex.nearshore.zuul.util;
 
public class Errors {
	public static int  InaccessibleWSDLException =2001;
	public static int  MalformedURLException =2002; 
	public static int  ServerSOAPFaultException =2003; 
	public static int  ServerException =2004;
	public static int  ExceptionDigitemServicesService =2004;
	public static int  ExceptionDataReq =2005;
	
	
	
	
	public static int  IncorrectoOpenSessionID =7006;
	public static int  DataUserInMemoryNoFound =7007;//no hay session en redis
	public static int  PassInMemoriaNotFound =7008;
	public static int  ErrorInSystem =7009;
	public static int  MalformedJson =7010;
	public static int  InvalidValueExpected =7011;
	 
	
	public static int  ExceptionServletUploadService =2012;
}
