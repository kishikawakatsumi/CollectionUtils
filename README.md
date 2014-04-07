# CollectionUtils ![License MIT](https://go-shields.herokuapp.com/license-MIT-yellow.png) 

[![Version](https://cocoapod-badges.herokuapp.com/v/CollectionUtils/badge.png)](https://cocoapod-badges.herokuapp.com/v/CollectionUtils/badge.png)
[![Platform](https://cocoapod-badges.herokuapp.com/p/CollectionUtils/badge.png)](https://cocoapod-badges.herokuapp.com/p/CollectionUtils/badge.png)
[![Build Status](https://travis-ci.org/kishikawakatsumi/CollectionUtils.png?branch=master)](https://travis-ci.org/kishikawakatsumi/CollectionUtils)
[![Analytics](https://ga-beacon.appspot.com/UA-4291014-9/CollectionUtils/README.md)](https://github.com/igrigorik/ga-beacon)

Useful utilities for Objective-C collection classes. 

## CollectionUtils/Compact
Subclasses of NSArray and NSDictionary to recursively remove NSNull objects automatically with little performance penalty. It is useful for JSON returned from web services.

### Usage

#### Remove `NSNull` values from an array

```objc
NSArray *array = @[@"0", @"1", [NSNull null], @"2", [NSNull null], @"3"];
NSArray *compactArray = [array cu_compactArray];
//=> ["0", "1", "2", "3"]
```

#### Remove `NSNull` values from a dictionary

```objc
NSDictionary *dictionary = @{@"one": @"1",
                             @"null": [NSNull null],
                             @"two": @"2",
                             @"three": @"3"};
NSDictionary *compactDictionary = [dictionary cu_compactDictionary];
 //=> {"one": "1", "two": "2", "three": "3"}
```

#### Recursively remove all `NSNull` values by default

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

#### Remove all `NSNull` values from JSON returned from web services.

```objc
id object = [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
id result =  [object cu_compactJSONObject];
```

#### `CUJSONSerialization` is a convienience class to remove `NSNull` values from JSON

```objc
id result = [CUJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
```

#### [AFNetworking](https://github.com/AFNetworking/AFNetworking) Additions
#### `CUJSONResponseSerializer` (for AFNetworking 2.x)

```objc
AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
manager.responseSerializer = [CUJSONResponseSerializer serializer];

[manager GET:@"http://example.com/resources.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"JSON: %@", responseObject);
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
}];
```

#### `CUJSONRequestOperation` (for AFNetworking 1.x)

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

## Requirements
- iOS 4.3 or later
- OS X 10.6 or later

## Installation

CollectionUtils is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "CollectionUtils"

If you want to use [AFNetworking](https://github.com/AFNetworking/AFNetworking) additions,
add the following line:

    pod "CollectionUtils/AFNetworking"

if you use older version AFNetworking,

    pod "CollectionUtils/AFNetworking-1.x"

## Author

kishikawa katsumi, kishikawakatsumi@mac.com

## License

[Apache]: http://www.apache.org/licenses/LICENSE-2.0
[MIT]: http://www.opensource.org/licenses/mit-license.php
[GPL]: http://www.gnu.org/licenses/gpl.html
[BSD]: http://opensource.org/licenses/bsd-license.php

CollectionUtils is available under the [MIT license][MIT]. See the LICENSE file for more info.
