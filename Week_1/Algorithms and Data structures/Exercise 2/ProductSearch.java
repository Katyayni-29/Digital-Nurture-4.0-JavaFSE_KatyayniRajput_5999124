import java.util.Arrays;
import java.util.Comparator;
import java.util.Scanner;

class Product { 
    int productId;
    String productName;
    String category;

    public Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    @Override
    public String toString() {
        return productName + " (ID: " + productId + ", Category: " + category + ")";
    }
}

public class ProductSearch {
    public static Product linearSearch(Product[] products, int productId) {
        for (Product product : products) {
            if (product.productId == productId) {
                return product;
            }
        }
        return null;
    }

    // Binary search method
    public static Product binarySearch(Product[] products, int productId) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;

            if (products[mid].productId == productId) {
                return products[mid];
            }

            if (products[mid].productId < productId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Enter the number of products: ");
        int numberOfProducts = scanner.nextInt();
        scanner.nextLine();

        Product[] products = new Product[numberOfProducts];

        for (int i = 0; i < numberOfProducts; i++) {
            System.out.print("Enter product ID for product " + (i + 1) + ": ");
            int productId = scanner.nextInt();
            scanner.nextLine();

            System.out.print("Enter product name for product " + (i + 1) + ": ");
            String productName = scanner.nextLine();

            System.out.print("Enter category for product " + (i + 1) + ": ");
            String category = scanner.nextLine();

            products[i] = new Product(productId, productName, category);
        }

        Arrays.sort(products, new Comparator<Product>() {
            public int compare(Product a, Product b) {
                if (a.productId < b.productId)
                    return -1;
                else if (a.productId > b.productId)  
                    return 1;
                else
                    return 0;
            }
        });

        System.out.println("\nProducts sorted by ID:");
        for (Product p : products) {
            System.out.println(p);
        }

        System.out.print("\nEnter the product ID to search: ");
        int searchId = scanner.nextInt();
      
        long startTime = System.nanoTime();
        Product foundProductLinear = linearSearch(products, searchId);
        long linearTime = System.nanoTime() - startTime;
        
        if (foundProductLinear != null) {
            System.out.println("Product found using Linear Search: " + foundProductLinear);
        } else {
            System.out.println("Product not found using Linear Search.");
        }
        System.out.println("Linear Search Time: " + linearTime + " nanoseconds");

        startTime = System.nanoTime();
        Product foundProductBinary = binarySearch(products, searchId);
        long binaryTime = System.nanoTime() - startTime;
        
        if (foundProductBinary != null) {
            System.out.println("Product found using Binary Search: " + foundProductBinary);
        } else {
            System.out.println("Product not found using Binary Search.");
        }
        System.out.println("Binary Search Time: " + binaryTime + " nanoseconds");

        if (linearTime > 0 && binaryTime > 0) {
            double speedup = (double) linearTime / binaryTime;
            System.out.printf("Binary search was %.2fx faster than linear search\n", speedup);
        }

        scanner.close();
    }
}
