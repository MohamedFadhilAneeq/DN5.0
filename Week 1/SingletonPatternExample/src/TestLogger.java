public class TestLogger {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        if (logger1==logger2) {
            System.out.println("Both Are THe Same Exact Instance");            
        }
        else{
            System.out.println("Multiple Instances Created");
        }
    }
}