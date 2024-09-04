// import ballerina/grpc;

// listener grpc:Listener ep = new (9090);

// @grpc:Descriptor {value: ONLINESHOPPING_DESC}
// service "ShoppingService" on ep {

//     remote function addProduct(AddProductRequest value) returns AddProductResponse|error {
//     }

//     remote function updateProduct(UpdateProductRequest value) returns UpdateProductResponse|error {
//     }

//     remote function removeProduct(RemoveProductRequest value) returns RemoveProductResponse|error {
//     }

//     remote function listAllOrders(EmptyRequest value) returns OrderList|error {
//     }

//     remote function listAvailableProducts(EmptyRequest value) returns ProductList|error {
//     }

//     remote function searchProduct(SearchProductRequest value) returns SearchProductResponse|error {
//     }

//     remote function addToCart(AddToCartRequest value) returns CartResponse|error {
//     }

//     remote function placeOrder(PlaceOrderRequest value) returns OrderResponse|error {
//     }

//     remote function createUsers(stream<UserRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
//     }
// }

