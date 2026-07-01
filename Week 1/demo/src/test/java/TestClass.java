import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class TestClass {
    @Test
    public void testAddition() {
        int a = 2;
        int b = 3;
        int expectedSum = 5;
        assertEquals(expectedSum, a + b);
        System.out.println("Test passed: " + a + " + " + b + " = " + expectedSum);
    }
}
