package java_usecase.smartpay.service.exception;

public class InvalidReadingException extends RuntimeException{
    public InvalidReadingException(String message){
        super(message);
    }
}
