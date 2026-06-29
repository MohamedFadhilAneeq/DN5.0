/**
 * FinancialForecast
 */
public class FinancialForecast {
    public static double predictFutureValue(double currentValue, double growthRate, int years) {
        if (years <= 0) {
            return currentValue;
        }

        double nextYearValue = currentValue * (1 + growthRate);
        
        return predictFutureValue(nextYearValue, growthRate, years - 1);
    }

    public static void main(String[] args) {
        double initialInvestment = 10000.0; 
        double annualGrowthRate = 0.05;     
        int projectionYears = 5;            

        double futureValue = predictFutureValue(initialInvestment, annualGrowthRate, projectionYears);
        
        System.out.printf("Projected Value after %d years: $%.2f%n", projectionYears, futureValue);
    }
}