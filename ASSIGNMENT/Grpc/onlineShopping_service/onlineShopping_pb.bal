import ballerina/grpc;
import ballerina/protobuf;

public const string ONLINESHOPPING_DESC = "0A146F6E6C696E6553686F7070696E672E70726F746F120E6F6E6C696E6553686F7070696E6722B5010A1141646450726F647563745265717565737412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128015205707269636512240A0D73746F636B5175616E74697479180420012805520D73746F636B5175616E7469747912100A03736B751805200128095203736B75121C0A09617661696C61626C651806200128085209617661696C61626C6522360A1241646450726F64756374526573706F6E736512200A0B70726F64756374436F6465180120012809520B70726F64756374436F646522C8010A1455706461746550726F647563745265717565737412200A0B70726F64756374436F6465180120012809520B70726F64756374436F646512120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12140A0570726963651804200128015205707269636512240A0D73746F636B5175616E74697479180520012805520D73746F636B5175616E74697479121C0A09617661696C61626C651806200128085209617661696C61626C65224B0A1555706461746550726F64756374526573706F6E736512180A077375636365737318012001280852077375636365737312180A076D65737361676518022001280952076D65737361676522380A1452656D6F766550726F647563745265717565737412200A0B70726F64756374436F6465180120012809520B70726F64756374436F6465225A0A1552656D6F766550726F64756374526573706F6E736512410A0F7570646174656450726F647563747318012003280B32172E6F6E6C696E6553686F7070696E672E50726F64756374520F7570646174656450726F6475637473220E0A0C456D70747952657175657374223A0A094F726465724C697374122D0A066F726465727318012003280B32152E6F6E6C696E6553686F7070696E672E4F7264657252066F7264657273225D0A0B557365725265717565737412160A067573657249641801200128095206757365724964121A0A08757365724E616D651802200128095208757365724E616D65121A0A0875736572547970651803200128095208757365725479706522490A134372656174655573657273526573706F6E736512320A146E756D6265724F6655736572734372656174656418012001280552146E756D6265724F6655736572734372656174656422420A0B50726F647563744C69737412330A0870726F647563747318012003280B32172E6F6E6C696E6553686F7070696E672E50726F64756374520870726F647563747322280A1453656172636850726F647563745265717565737412100A03736B751801200128095203736B7522640A1553656172636850726F64756374526573706F6E736512310A0770726F6475637418012001280B32172E6F6E6C696E6553686F7070696E672E50726F64756374520770726F6475637412180A076D65737361676518022001280952076D657373616765223C0A10416464546F436172745265717565737412160A06757365724964180120012809520675736572496412100A03736B751802200128095203736B7522560A0C43617274526573706F6E736512160A066361727449641801200128095206636172744964122E0A056974656D7318022003280B32182E6F6E6C696E6553686F7070696E672E436172744974656D52056974656D7322430A11506C6163654F726465725265717565737412160A06757365724964180120012809520675736572496412160A06636172744964180220012809520663617274496422430A0D4F72646572526573706F6E736512180A076F72646572496418012001280952076F72646572496412180A076D65737361676518022001280952076D65737361676522CD010A0750726F6475637412200A0B70726F64756374436F6465180120012809520B70726F64756374436F646512120A046E616D6518022001280952046E616D6512200A0B6465736372697074696F6E180320012809520B6465736372697074696F6E12140A0570726963651804200128015205707269636512240A0D73746F636B5175616E74697479180520012805520D73746F636B5175616E7469747912100A03736B751806200128095203736B75121C0A09617661696C61626C651807200128085209617661696C61626C6522380A08436172744974656D12100A03736B751801200128095203736B75121A0A087175616E7469747918022001280552087175616E7469747922A8010A054F7264657212180A076F72646572496418012001280952076F72646572496412160A06757365724964180220012809520675736572496412330A0870726F647563747318032003280B32172E6F6E6C696E6553686F7070696E672E50726F64756374520870726F647563747312200A0B746F74616C416D6F756E74180420012801520B746F74616C416D6F756E7412160A067374617475731805200128095206737461747573328E060A0F53686F7070696E675365727669636512530A0A61646450726F6475637412212E6F6E6C696E6553686F7070696E672E41646450726F64756374526571756573741A222E6F6E6C696E6553686F7070696E672E41646450726F64756374526573706F6E7365125C0A0D75706461746550726F6475637412242E6F6E6C696E6553686F7070696E672E55706461746550726F64756374526571756573741A252E6F6E6C696E6553686F7070696E672E55706461746550726F64756374526573706F6E7365125C0A0D72656D6F766550726F6475637412242E6F6E6C696E6553686F7070696E672E52656D6F766550726F64756374526571756573741A252E6F6E6C696E6553686F7070696E672E52656D6F766550726F64756374526573706F6E736512480A0D6C697374416C6C4F7264657273121C2E6F6E6C696E6553686F7070696E672E456D707479526571756573741A192E6F6E6C696E6553686F7070696E672E4F726465724C69737412510A0B6372656174655573657273121B2E6F6E6C696E6553686F7070696E672E55736572526571756573741A232E6F6E6C696E6553686F7070696E672E4372656174655573657273526573706F6E7365280112520A156C697374417661696C61626C6550726F6475637473121C2E6F6E6C696E6553686F7070696E672E456D707479526571756573741A1B2E6F6E6C696E6553686F7070696E672E50726F647563744C697374125C0A0D73656172636850726F6475637412242E6F6E6C696E6553686F7070696E672E53656172636850726F64756374526571756573741A252E6F6E6C696E6553686F7070696E672E53656172636850726F64756374526573706F6E7365124B0A09616464546F4361727412202E6F6E6C696E6553686F7070696E672E416464546F43617274526571756573741A1C2E6F6E6C696E6553686F7070696E672E43617274526573706F6E7365124E0A0A706C6163654F7264657212212E6F6E6C696E6553686F7070696E672E506C6163654F72646572526571756573741A1D2E6F6E6C696E6553686F7070696E672E4F72646572526573706F6E7365620670726F746F33";

public isolated client class ShoppingServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ONLINESHOPPING_DESC);
    }

    isolated remote function addProduct(AddProductRequest|ContextAddProductRequest req) returns AddProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddProductResponse>result;
    }

    isolated remote function addProductContext(AddProductRequest|ContextAddProductRequest req) returns ContextAddProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddProductResponse>result, headers: respHeaders};
    }

    isolated remote function updateProduct(UpdateProductRequest|ContextUpdateProductRequest req) returns UpdateProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UpdateProductResponse>result;
    }

    isolated remote function updateProductContext(UpdateProductRequest|ContextUpdateProductRequest req) returns ContextUpdateProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UpdateProductResponse>result, headers: respHeaders};
    }

    isolated remote function removeProduct(RemoveProductRequest|ContextRemoveProductRequest req) returns RemoveProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveProductResponse>result;
    }

    isolated remote function removeProductContext(RemoveProductRequest|ContextRemoveProductRequest req) returns ContextRemoveProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveProductResponse>result, headers: respHeaders};
    }

    isolated remote function listAllOrders(EmptyRequest|ContextEmptyRequest req) returns OrderList|grpc:Error {
        map<string|string[]> headers = {};
        EmptyRequest message;
        if req is ContextEmptyRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/listAllOrders", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderList>result;
    }

    isolated remote function listAllOrdersContext(EmptyRequest|ContextEmptyRequest req) returns ContextOrderList|grpc:Error {
        map<string|string[]> headers = {};
        EmptyRequest message;
        if req is ContextEmptyRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/listAllOrders", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderList>result, headers: respHeaders};
    }

    isolated remote function listAvailableProducts(EmptyRequest|ContextEmptyRequest req) returns ProductList|grpc:Error {
        map<string|string[]> headers = {};
        EmptyRequest message;
        if req is ContextEmptyRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/listAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ProductList>result;
    }

    isolated remote function listAvailableProductsContext(EmptyRequest|ContextEmptyRequest req) returns ContextProductList|grpc:Error {
        map<string|string[]> headers = {};
        EmptyRequest message;
        if req is ContextEmptyRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/listAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ProductList>result, headers: respHeaders};
    }

    isolated remote function searchProduct(SearchProductRequest|ContextSearchProductRequest req) returns SearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SearchProductResponse>result;
    }

    isolated remote function searchProductContext(SearchProductRequest|ContextSearchProductRequest req) returns ContextSearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SearchProductResponse>result, headers: respHeaders};
    }

    isolated remote function addToCart(AddToCartRequest|ContextAddToCartRequest req) returns CartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CartResponse>result;
    }

    isolated remote function addToCartContext(AddToCartRequest|ContextAddToCartRequest req) returns ContextCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CartResponse>result, headers: respHeaders};
    }

    isolated remote function placeOrder(PlaceOrderRequest|ContextPlaceOrderRequest req) returns OrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <OrderResponse>result;
    }

    isolated remote function placeOrderContext(PlaceOrderRequest|ContextPlaceOrderRequest req) returns ContextOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("onlineShopping.ShoppingService/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <OrderResponse>result, headers: respHeaders};
    }

    isolated remote function createUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("onlineShopping.ShoppingService/createUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUserRequest(UserRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUserRequest(ContextUserRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCreateUsersResponse() returns CreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <CreateUsersResponse>payload;
        }
    }






    isolated remote function receiveContextCreateUsersResponse() returns ContextCreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <CreateUsersResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public isolated client class ShoppingServiceRemoveProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendRemoveProductResponse(RemoveProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextRemoveProductResponse(ContextRemoveProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceOrderResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendOrderResponse(OrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextOrderResponse(ContextOrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceProductListCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendProductList(ProductList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextProductList(ContextProductList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceSearchProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSearchProductResponse(SearchProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSearchProductResponse(ContextSearchProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceOrderListCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendOrderList(OrderList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextOrderList(ContextOrderList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceUpdateProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUpdateProductResponse(UpdateProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUpdateProductResponse(ContextUpdateProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceCartResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCartResponse(CartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCartResponse(ContextCartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceAddProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddProductResponse(AddProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddProductResponse(ContextAddProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }









    

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceCreateUsersResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateUsersResponse(CreateUsersResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateUsersResponse(ContextCreateUsersResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextUserRequestStream record {|
    stream<UserRequest, error?> content;
    map<string|string[]> headers;
|};

public type ContextAddProductResponse record {|
    AddProductResponse content;
    map<string|string[]> headers;
|};

public type ContextOrderResponse record {|
    OrderResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveProductResponse record {|
    RemoveProductResponse content;
    map<string|string[]> headers;
|};

public type ContextAddProductRequest record {|
    AddProductRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductRequest record {|
    UpdateProductRequest content;
    map<string|string[]> headers;
|};

public type ContextSearchProductRequest record {|
    SearchProductRequest content;
    map<string|string[]> headers;
|};

public type ContextAddToCartRequest record {|
    AddToCartRequest content;
    map<string|string[]> headers;
|};

public type ContextCartResponse record {|
    CartResponse content;
    map<string|string[]> headers;
|};

public type ContextProductList record {|
    ProductList content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrderRequest record {|
    PlaceOrderRequest content;
    map<string|string[]> headers;
|};

public type ContextRemoveProductRequest record {|
    RemoveProductRequest content;
    map<string|string[]> headers;
|};

public type ContextEmptyRequest record {|
    EmptyRequest content;
    map<string|string[]> headers;
|};

public type ContextOrderList record {|
    OrderList content;
    map<string|string[]> headers;
|};

public type ContextSearchProductResponse record {|
    SearchProductResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersResponse record {|
    CreateUsersResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductResponse record {|
    UpdateProductResponse content;
    map<string|string[]> headers;
|};

public type ContextUserRequest record {|
    UserRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type Order record {|
    string orderId = "";
    string userId = "";
    Product[] products = [];
    float totalAmount = 0.0;
    string status = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type AddProductResponse record {|
    string productCode = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type Product record {|
    string productCode = "";
    string name = "";
    string description = "";
    float price = 0.0;
    int stockQuantity = 0;
    string sku = "";
    boolean available = false;
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type OrderResponse record {|
    string orderId = "";
    string message = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type CartItem record {|
    string sku = "";
    int quantity = 0;
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type RemoveProductResponse record {|
    Product[] updatedProducts = [];
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type AddProductRequest record {|
    string name = "";
    string description = "";
    float price = 0.0;
    int stockQuantity = 0;
    string sku = "";
    boolean available = false;
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type UpdateProductRequest record {|
    string productCode = "";
    string name = "";
    string description = "";
    float price = 0.0;
    int stockQuantity = 0;
    boolean available = false;
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type SearchProductRequest record {|
    string sku = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type AddToCartRequest record {|
    string userId = "";
    string sku = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type CartResponse record {|
    string cartId = "";
    CartItem[] items = [];
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type ProductList record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type PlaceOrderRequest record {|
    string userId = "";
    string cartId = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type RemoveProductRequest record {|
    string productCode = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type EmptyRequest record {|
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type OrderList record {|
    Order[] orders = [];
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type SearchProductResponse record {|
    Product product = {};
    string message = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type CreateUsersResponse record {|
    int numberOfUsersCreated = 0;
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type UpdateProductResponse record {|
    boolean success = false;
    string message = "";
|};

@protobuf:Descriptor {value: ONLINESHOPPING_DESC}
public type UserRequest record {|
    string userId = "";
    string userName = "";
    string userType = "";
|};

