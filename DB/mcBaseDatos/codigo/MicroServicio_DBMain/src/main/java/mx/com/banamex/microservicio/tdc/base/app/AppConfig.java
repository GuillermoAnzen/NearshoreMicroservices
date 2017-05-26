package mx.com.banamex.microservicio.tdc.base.app;

import java.io.Serializable;
import java.util.HashMap;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

@Configuration
public class AppConfig {
    
   @Bean
   public MessagesErrors messagesErrors() { 
	   return new MessagesErrors();
   
   }
   public class MessagesErrors implements Serializable  {
	   public HashMap  getErrores(BindingResult result){
			HashMap errores  = new HashMap();
			for(int i = 0 ; i < result.getAllErrors().size() ; i++ ){			 		
		 		FieldError error = (FieldError) result.getAllErrors().get(i);
		 		errores.put(error.getField(),error.getDefaultMessage());
		 	}
	        return errores;
		}
   }   
}



