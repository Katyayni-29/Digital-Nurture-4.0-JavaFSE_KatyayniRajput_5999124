public class TestLogger {
    public static void main(String[] args) {

        System.out.println("Singleton Pattern Test");

        Logger logger1 = Logger.getInstance();
        logger1.log("First log message");

        Logger logger2 = Logger.getInstance();
        logger2.log("Second log message");

        System.out.println("\nChecking instance equality");
        if (logger1 == logger2) {
            System.out.println("Success");
        } else {
            System.out.println("Error");
        }
    }
}
