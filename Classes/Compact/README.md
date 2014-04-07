CollectionUtils/Compact
===============

Subclasses of NSArray and NSDictionary to recursively remove all NSNull values automatically with little performance penalty.  
It is useful for JSON returned from web services.

### Usage

#### Remove NSNull values from an array

```objc
NSArray *array = @[@"0", @"1", [NSNull null], @"2", [NSNull null], @"3"];
NSArray *compactArray = [array cu_compactArray];
//=> ["0", "1", "2", "3"]
```

#### Remove NSNull values from a dictionary

```objc
NSDictionary *dictionary = @{@"one": @"1",
                             @"null": [NSNull null],
                             @"two": @"2",
                             @"three": @"3"};
NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
 //=> {"one": "1", "two": "2", "three": "3"}
```

#### Recursively remove all NSNull values by default

```objc
NSArray *array = @[@"0",
                   @"1",
                   [NSNull null],
                   @"2",
                   @{@"one": @"1",
                     @"null": [NSNull null],
                     @"two": @"2",
                     @"three": @"3"},
                   @"4"];
NSMutableArray *compactArray = [array cu_compactArray];
//=> ["0", "1", "2", {"one": "1", "two": "2", "three": "3"}, "4"]
```

#### Remove all NSNull values from JSON returned from web services.

```objc
id object = [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
id result =  [object cu_compactJSONObject];
```

#### CUJSONSerialization is a convienience class to remove all NSNull values from JSON data

```objc
id result = [CUJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
```

#### [AFNetworking](https://github.com/AFNetworking/AFNetworking) Additions
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

### Little performance penalty
#### How it works
`CUCompactArray` and `CUCompactDictionary` just wrap the original array/dictionary to behave as if do not have `NSNull` values.

To remove `NSNull` values for the nested collection is delayed until the nested array/dictionary is really accessed.  
It is performed only for one level at a time.

```objc
- (NSUInteger)count
{
    return self.original.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    id object = self.original[index];
    if ([object isKindOfClass:[CUCompactArray class]] || [object isKindOfClass:[CUCompactDictionary class]]) {
        return object;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        return [CUCompactArray arrayWithArray:object];
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [CUCompactDictionary dictionaryWithDictionary:object];
    }
    return object;
}
```

```objc
- (NSUInteger)count
{
    return self.original.count;
}

- (id)objectForKey:(id)aKey
{
    id object = self.original[aKey];
    if ([object isKindOfClass:[CUCompactArray class]] || [object isKindOfClass:[CUCompactDictionary class]]) {
        return object;
    }
    if ([object isKindOfClass:[NSArray class]]) {
        return [[CUCompactArray alloc] initWithArray:object];
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        return [[CUCompactDictionary alloc] initWithDictionary:object];
    }
    return object;
}

- (NSEnumerator *)keyEnumerator
{
    return self.original.keyEnumerator;
}
```
