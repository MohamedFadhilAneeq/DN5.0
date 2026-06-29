class Product {
    int productId;
    String productName;
    String category;
    Product(int id,String name, String category){
        this.productId = id;
        this.productName = name;
        this.category = category;
    }
}

public class EcommercePlatformSearchFunction{
    public static Product linearSearch(Product[] products,int target){
        for(Product p : products){
            if(p.productId == target){
                return p;
            }
        }
        return null;
    }
    public static Product binarySearch(Product[] products,int target){
        int left = 0;
        int right = products.length-1;
        while(left<=right){
            int mid = left + (right-left)/2;
            if(products[mid].productId==target){
                return products[mid];
            }
            if(products[mid].productId<target){
                left = mid + 1;
            }
            else{
                right = mid - 1;
            }
        }
        return null;
    }
    public static void main(String[] args) {
        Product[] unsorted = {
            new Product(340, "Coffee Maker", "Appliances"),
            new Product(101, "Laptop", "Electronics"),
            new Product(499, "Headphones", "Electronics"),
            new Product(205, "Desk Chair", "Furniture")
        };

        Product[] sorted = {
            new Product(101, "Laptop", "Electronics"),
            new Product(205, "Desk Chair", "Furniture"),
            new Product(340, "Coffee Maker", "Appliances"),
            new Product(499, "Headphones", "Electronics")
        };

        Product linear = linearSearch(unsorted,101);
        System.out.println(linear.productName);

        Product binary = binarySearch(sorted, 340);
        System.out.println(binary.productName);
    }
}

