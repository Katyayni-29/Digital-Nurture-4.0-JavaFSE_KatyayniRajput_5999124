public class FinancialForecast {

    // 1. Recursive version
    public static double futureValueRecursive(double currentValue, double growthRate, int years) {
        if (years == 0) {
            return currentValue;
        }
        return (1 + growthRate) * futureValueRecursive(currentValue, growthRate, years - 1);
    }

    // 2. Optimized version using memoization
    public static double futureValueMemo(double currentValue, double growthRate, int years, Double[] memo) {
        if (years == 0) {
            return currentValue;
        }
        if (memo[years] != null) {
            return memo[years];
        }
        memo[years] = (1 + growthRate) * futureValueMemo(currentValue, growthRate, years - 1, memo);
        return memo[years];
    }

    // 3. Iterative version
    public static double futureValueIterative(double principal, double rate, int years) {
        for (int i = 0; i < years; i++) {
            principal *= (1 + rate);
        }
        return principal;
    }

    // 4. Formula-based version
    public static double futureValueFormula(double principal, double rate, int years) {
        return principal * Math.pow(1 + rate, years);
    }

    // Main method to demonstrate all versions
    public static void main(String[] args) {
        double currentValue = 1000;  
        double growthRate = 0.10;   
        int years = 5;             

        // 1. Recursive method
        double resultRecursive = futureValueRecursive(currentValue, growthRate, years);
        System.out.printf("Future value (Recursive) after %d years: %.2f\n", years, resultRecursive);

        // 2. Memoization method
        Double[] memo = new Double[years + 1];
        double resultMemo = futureValueMemo(currentValue, growthRate, years, memo);
        System.out.printf("Future value (Memoization) after %d years: %.2f\n", years, resultMemo);

        // 3. Iterative method
        double resultIterative = futureValueIterative(currentValue, growthRate, years);
        System.out.printf("Future value (Iterative) after %d years: %.2f\n", years, resultIterative);

        // 4. Formula-based method
        double resultFormula = futureValueFormula(currentValue, growthRate, years);
        System.out.printf("Future value (Formula) after %d years: %.2f\n", years, resultFormula);
    }
}
