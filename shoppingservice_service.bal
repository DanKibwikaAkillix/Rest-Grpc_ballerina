import ballerina/grpc;
import ballerina/uuid;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: ONLINESHOPPING_DESC}
service "ShoppingService" on ep {
     //
    # Description.
    #
    # + value - parameter description
    # + return - return value description
    remote function addProduct(AddProductRequest value) returns AddProductResponse|error {
        if (value.name.trim().length() == 0) {
            return error("Product name cannot be empty");
        }

        string productCode = uuid:createType1AsString();
        boolean addSuccess = extracted(value, productCode);
        if (!addSuccess) {
            return error("Failed to add product");
        }

        return {
            productCode: productCode
        };
    }

    remote function updateProduct(UpdateProductRequest value) returns UpdateProductResponse|error {
        if (value.productCode.trim().length() == 0) {
            return error("Product ID cannot be empty");
        }

        boolean updateSuccess = updateExistingProduct(value);
        if (!updateSuccess) {
            return error("Failed to update product");
        }

        return {
            success: true,
            message: string `Product ${value.productCode} updated successfully`
        };
    }

    remote function removeProduct(RemoveProductRequest value) returns RemoveProductResponse|error {
        if (value.productCode.trim().length() == 0) {
            return error("Product ID cannot be empty");
        }

        Product[] updatedProducts = removeProductById(value.productCode);
        return {
            updatedProducts: updatedProducts
        };
    }

    remote function listAllOrders(EmptyRequest value) returns OrderList {
        Order[] orders = getAllOrders();
        return {
            orders: orders
        };
    }

    remote function createUsers(stream<UserRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
        int createdCount = 0;
        check clientStream.forEach(function(UserRequest req) {
            boolean success = createUser(req);
            if (success) {
                createdCount += 1;
            }
        });
        return {
            numberOfUsersCreated: createdCount
        };
    }

    remote function listAvailableProducts(EmptyRequest value) returns ProductList {
        Product[] products = getAvailableProducts();
        return {
            products: products
        };
    }

    remote function searchProduct(SearchProductRequest value) returns SearchProductResponse {
        Product? product = findProductBySku(value.sku);
        if (product is Product) {
            return {
                product: product,
                message: "Product found"
            };
        } else {
            return {
                message: "Product not found"
            };
        }
    }

    remote function addToCart(AddToCartRequest value) returns CartResponse|error {
        CartItem[] updatedItems = addItemToCart(value.userId, value.sku);
        return {
            cartId: value.userId,
            items: updatedItems
        };
    }

    remote function placeOrder(PlaceOrderRequest value) returns OrderResponse|error {
        string orderId = createOrder(value.userId, value.cartId);
        return {
            orderId: orderId,
            message: "Order placed successfully"
        };
    }
}

function extracted(AddProductRequest value, string productCode) returns boolean {
    boolean addSuccess = extracted1(value, productCode);
    return addSuccess;
}

function extracted1(AddProductRequest value, string productCode) returns boolean {
    boolean addSuccess = extracted2(value, productCode);
    return addSuccess;
}

function extracted2(AddProductRequest value, string productCode) returns boolean {
    boolean addSuccess = saveNewProduct(value, productCode);
    return addSuccess;
}

function createOrder(string s, string s1) returns string {
    return "";
}

function addItemToCart(string s, string s1) returns CartItem[] {
    return [];
}

function findProductBySku(string s) returns Product? {
    return ();
}

function getAvailableProducts() returns Product[] {
    return [];
}

function createUser(UserRequest r) returns boolean {
    return false;
}

function getAllOrders() returns Order[] {
    return [];
}

function removeProductById(string s) returns Product[] {
    return [];
}

function updateExistingProduct(UpdateProductRequest r) returns boolean {
    return false;
}

function saveNewProduct(AddProductRequest r, string productCode) returns boolean {
    return false;
}

// Type definitions based on the protobuf file
type AddProductRequests record {
    string name;
    string description;
    float price;
    int stockQuantity;
    string sku;
    boolean available;
};

type AddProductResponses record {
    string productCode;
};

type UpdateProductRequests record {
    string productCode;
    string name;
    string description;
    float price;
    int stockQuantity;
    boolean available;
};

type UpdateProductResponses record {
    boolean success;
    string message;
};

type RemoveProductRequests record {
    string productCode;
};

type RemoveProductResponses record {
    Product[] updatedProducts;
};

type EmptyRequests record {};

type OrderLists record {
    Order[] orders;
};

type UserRequests record {
    string userId;
    string userName;
    string userType;
};

type CreateUsersResponses record {
    int numberOfUsersCreated;
};

type ProductLists record {
    Product[] products;
};

type SearchProductRequests record {
    string sku;
};

type SearchProductResponses record {
    Product product?;
    string message;
};

type AddToCartRequests record {
    string userId;
    string sku;
};

type CartResponses record {
    string cartId;
    CartItem[] items;
};

type PlaceOrderRequests record {
    string userId;
    string cartId;
};

type OrderResponses record {
    string orderId;
    string message;
};

type Products record {
    string productCode;
    string name;
    string description;
    float price;
    int stockQuantity;
    string sku;
    boolean available;
};

type CartItems record {
    string sku;
    int quantity;
};

type Orders record {
    string orderId;
    string userId;
    Product[] products;
    float totalAmount;
    string status;
};
