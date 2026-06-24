public class Logger {
    public static Logger obj;
    
    private Logger(){}

    public static Logger getInstance(){
        if(obj == null)
            obj = new Logger();
        return obj;
    }
}
