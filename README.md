# CollectionUtils

[![CI Status](http://img.shields.io/travis/kishikawakatsumi/CollectionUtils.svg?style=flat)](https://travis-ci.org/kishikawakatsumi/CollectionUtils)
[![Coverage Status](https://img.shields.io/coveralls/kishikawakatsumi/CollectionUtils.svg?style=flat)](https://coveralls.io/r/kishikawakatsumi/CollectionUtils?branch=master)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/CollectionUtils.svg?style=flat)](http://cocoadocs.org/docsets/CollectionUtils)
[![License](https://img.shields.io/cocoapods/l/CollectionUtils.svg?style=flat)](http://cocoadocs.org/docsets/CollectionUtils)
[![Platform](https://img.shields.io/cocoapods/p/CollectionUtils.svg?style=flat)](http://cocoadocs.org/docsets/CollectionUtils)


Useful utilities for Objective-C collection classes. 

## CollectionUtils/Compact
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

#### Install

    pod "CollectionUtils-AFNetworking"

#### Usage

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

#### Install

    pod "CollectionUtils-AFNetworking-1.3"

#### Usage

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

## Requirements
- iOS 4.3 or later
- OS X 10.6 or later

## Installation

CollectionUtils is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "CollectionUtils"

If you want to use [AFNetworking](https://github.com/AFNetworking/AFNetworking) additions,
add the following line:

    pod "CollectionUtils-AFNetworking"

if you use older version AFNetworking,

    pod "CollectionUtils-AFNetworking-1.3"

## Author

kishikawa katsumi, kishikawakatsumi@mac.com

## License

[Apache]: http://www.apache.org/licenses/LICENSE-2.0
[MIT]: http://www.opensource.org/licenses/mit-license.php
[GPL]: http://www.gnu.org/licenses/gpl.html
[BSD]: http://opensource.org/licenses/bsd-license.php

CollectionUtils is available under the [MIT license][MIT]. See the LICENSE file for more info.
