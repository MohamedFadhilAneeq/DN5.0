import org.junit.Before;
import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

// 1. A simple class mimicking your JavaScript MathUtils
class MathUtils {
    public int getFibonacciNumber(int n) {
        if (n <= 1) return n;
        int a = 0, b = 1, sum = 0;
        for (int i = 2; i <= n; i++) {
            sum = a + b;
            a = b;
            b = sum;
        }
        return sum;
    }
}

public class AAAPattern {
    
    // Declare the object at the class level so all methods can see it
    private MathUtils mathUtils;

    // SETUP: This replaces the initialization part of your "Arrange"
    @Before
    public void setUp() {
        System.out.println("Setting up: Initializing MathUtils...");
        mathUtils = new MathUtils();
    }

    // THE TEST: Using your exact AAA logic
    @Test
    public void testGetFibonacciNumber() {
        // Arrange: Define the input and what you expect
        int input = 6;
        int expectedOutput = 8;

        // Act: Test the method of the class
        int result = mathUtils.getFibonacciNumber(input);

        // Assert: Verify that the method produces the expected outcome
        assertEquals(expectedOutput, result);
    }

    // TEARDOWN: Clean up the environment after the test finishes
    @After
    public void tearDown() {
        System.out.println("Tearing down: Clearing MathUtils from memory...\n");
        mathUtils = null;
    }
}