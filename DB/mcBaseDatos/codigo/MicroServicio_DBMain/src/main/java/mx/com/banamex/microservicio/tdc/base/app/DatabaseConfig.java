package mx.com.banamex.microservicio.tdc.base.app;

import java.beans.PropertyVetoException;
//import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.mchange.v2.c3p0.ComboPooledDataSource;

@Configuration
public class DatabaseConfig {

  @Value("${db.driver}")
  private String DB_DRIVER;  
  @Value("${db.password}")
  private String DB_PASSWORD;  
  @Value("${db.url}")
  private String DB_URL;  
  @Value("${db.username}")
  private String DB_USERNAME;
  
  @Value("${org.apache.maxIdle}")
  private String maxIdle;
  @Value("${org.apache.minIdle}")
  private String minIdle;
  @Value("${org.apache.initialSize}")
  private String initialSize;
  @Value("${org.apache.maxActive}")
  private String maxActive;
  @Value("${org.apache.testWhileIdle}")
  private String testWhileIdle;
  @Value("${org.apache.removeAbandoned}")
  private String removeAbandoned;
  @Value("${org.apache.removeAbandonedTimeout}")
  private String removeAbandonedTimeout;
  @Value("${org.apache.maxWait}")
  private String maxWait;  
  
  @Value("${hibernate.c3p0.max_size}")
  private String c3p0_max_size;	
  @Value("${hibernate.c3p0.min_size}")
  private String c3p0_min_size;  
  @Value("${hibernate.c3p0.incremento}")
  private String c3p0_incremento;
  @Value("${hibernate.c3p0.reintentos_conection_fail}")
  private String c3p0_reintentos_conection_fail; 
  @Value("${hibernate.c3p0.generar_exception_fail_conection}")
  private String c3p0_generar_exception_fail_conection;  
  @Value("${hibernate.c3p0.close_conection_without_using}")
  private String c3p0_close_conection_without_using;
  
 
  private final Logger log = LoggerFactory.getLogger(DatabaseConfig.class);
 
  /*
  @Bean
  public javax.sql.DataSource dataSource() throws Exception {
	  
      final Properties pool = new Properties();
      pool.put("driverClassName", DB_DRIVER);
      pool.put("url", DB_URL);
      pool.put("username", DB_USERNAME);
      pool.put("password", DB_PASSWORD);
      pool.put("maxIdle", maxIdle); //maxIdle Numero maximo de conexiones del pool en todo momento
      pool.put("minIdle", minIdle); //minIdle Numero minimo de conexiones del pool en todo momento
      pool.put("initialSize", initialSize); //initialSize Numero de conexiones al inicio
      pool.put("maxActive", maxActive);
      pool.put("testWhileIdle", Boolean.parseBoolean(testWhileIdle));
      pool.put("removeAbandoned", Boolean.parseBoolean(removeAbandoned));
      pool.put("removeAbandonedTimeout", removeAbandonedTimeout);
      //pool.put("maxWait", maxWait);
      vercofig();
      return new org.apache.tomcat.jdbc.pool.DataSourceFactory().createDataSource(pool);
  }
  
  public void vercofig(){
	  
	  log.info("######Configuracion DB######");	  
	  log.info("URL:"+this.DB_URL);
	  log.info("DRIVER:"+this.DB_DRIVER);
	  log.info("USERNAME:"+this.DB_USERNAME);
	  log.info("PASSWORD:"+this.DB_PASSWORD);
	  log.info("maxIdle:"+this.maxIdle);
	  log.info("minIdle:"+this.minIdle);
	  log.info("initialSize:"+this.initialSize);
	  log.info("maxActive:"+this.maxActive);
	  log.info("testWhileIdle:"+this.testWhileIdle);
	  log.info("removeAbandoned:"+this.removeAbandoned);
	  log.info("removeAbandonedTimeout:"+this.removeAbandonedTimeout);
	  //log.info("maxWait:"+this.maxWait);
	  
  }
  */
  /*
  @Bean
  public DataSource dataSource() {
    DriverManagerDataSource dataSource = new DriverManagerDataSource();
    dataSource.setDriverClassName(DB_DRIVER);
    dataSource.setUrl(DB_URL);
    dataSource.setUsername(DB_USERNAME);
    dataSource.setPassword(DB_PASSWORD);
    return dataSource;
  }
  */
 
  @Bean
  public ComboPooledDataSource dataSource()   {	  
      ComboPooledDataSource dataSource = new ComboPooledDataSource();      
      // Configuramos el pool
      dataSource.setMinPoolSize(Integer.valueOf(c3p0_min_size));// Minimo de conexiones que tendra el pool
      dataSource.setMaxPoolSize(Integer.valueOf(c3p0_max_size));// Maximo numero de conexiones
      dataSource.setAcquireIncrement(Integer.valueOf(c3p0_incremento));// Numero de conexiones a crear cada incremento
      //dataSource.setAcquireRetryAttempts(Integer.valueOf(c3p0_reintentos_conection_fail));// Maximo numero de reintentos para conectar a base de datos    
      dataSource.setBreakAfterAcquireFailure(Boolean.valueOf(c3p0_generar_exception_fail_conection));// Que se genere una excepcion si no se puede conectar, en false para reconexion
      dataSource.setMaxIdleTime(Integer.parseInt(c3p0_close_conection_without_using));//cerrar agrupado Conexiones que no se usan durante segundos
      dataSource.setJdbcUrl(DB_URL);
      dataSource.setPassword(DB_PASSWORD);
      dataSource.setUser(DB_USERNAME);            
      try {
		dataSource.setDriverClass(DB_DRIVER);
      } catch (PropertyVetoException e) {
    	  e.printStackTrace();
      }      
      vercofig();      
      return dataSource;
  }	
  public void vercofig(){
	  
	  log.info("######Configuracion DB######");	  
	  log.info("URL:"+this.DB_URL);
	  log.info("DRIVER:"+this.DB_DRIVER);
	  log.info("USERNAME:"+this.DB_USERNAME);
	  log.info("PASSWORD:"+this.DB_PASSWORD);
	  log.info("MIN_SIZE_POOL:"+this.c3p0_min_size);
	  log.info("MAX_SIZE_POOL:"+this.c3p0_max_size);
	  log.info("INCREMENTO_POOL:"+this.c3p0_incremento);
	  log.info("REINTENTOS_CONEXION:"+this.c3p0_reintentos_conection_fail);
	  log.info("GENERAR_EXCEPTION_FAIL_CONEXION:"+this.c3p0_generar_exception_fail_conection);
	  log.info("CLOSE_CONEXION_SIN_USO:"+this.c3p0_close_conection_without_using);
  }

}