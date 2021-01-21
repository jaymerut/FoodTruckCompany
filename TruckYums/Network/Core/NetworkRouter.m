//
//  NetworkRouter.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "NetworkRouter.h"

// Delegates

// Utilities

// Globals

// Classes

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface NetworkRouter ()



@end



@implementation NetworkRouter


#pragma mark - Initialization
- (instancetype)init {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"%@ Failed to call designated initializer. Invoke `initWithClient:` instead.", NSStringFromClass([self class])] userInfo:nil];
}
- (instancetype)initWithClient:(NetworkClient *)client {
    if (self = [super init]) {
        _client = client;
    }
    return self;
}
- (instancetype)initWithClient:(NetworkClient *)client apiKey:(NSString *)apiKey {
    if (self = [super init]) {
        _apiKey = apiKey;
        _client = client;
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API



#pragma mark - Public API
- (NSURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    return [self.client requestWithMethod:method path:path parameters:parameters];
}
- (NSURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers {
    return [self.client requestWithMethod:method path:path parameters:parameters headers:headers];
}


#pragma mark - Delegate Methods



@end
