CollectionUtils/AFNetworking
===============

#### CollectionUtils [AFNetworking](https://github.com/AFNetworking/AFNetworking) Additions
#### CUJSONResponseSerializer (for AFNetworking 2.x)

```objc
AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
manager.responseSerializer = [CUJSONResponseSerializer serializer];

[manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"JSON: %@", responseObject);
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
}];
```

#### CUJSONRequestOperation (for AFNetworking 1.x)

```objc
NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://example.com/resources.json"]];
CUJSONRequestOperation *operation = [CUJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    NSLog(@"JSON: %@", JSON);
} failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    NSLog(@"Error: %@", error);
}];
[operation start];
```

```objc
AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://example.com/"]];
[client registerHTTPOperationClass:[CUJSONRequestOperation class]];
[client setDefaultHeader:@"Accept" value:@"application/json"];

[client getPath:@"resouce.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"JSON: %@", responseObject);
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
}];
```
