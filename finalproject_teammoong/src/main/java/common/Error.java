package common;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;


//@ControllerAdvice
//public class Error {
//
//	@ExceptionHandler(Exception.class)
//	public String handleException(Exception e) {
//		return "common/error500";
//	}
//	
//	
//	
//	
//	@ExceptionHandler(NoHandlerFoundException.class) //이런 Exception이 발생하고
//	@ResponseStatus(value = HttpStatus.NOT_FOUND) //그게 not found일때
//	public String noFound(NoHandlerFoundException e) {
//		return "common/error400";
//	}
//	
//	
//	
//}
