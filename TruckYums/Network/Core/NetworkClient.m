//
//  NetworkClient.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "NetworkClient.h"

// Delegates

// Utilities

// Globals

// Classes

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface NetworkClient ()



@end



@implementation NetworkClient


#pragma mark - Initialization
- (void)customInitNetworkClient {
    
    [self registerHTTPOperationClass:[AFRKJSONRequestOperation class]];
    
    // Accept HTTP Header
    [self setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    // Default to JSON parameter encoding
    [self setParameterEncoding:AFRKJSONParameterEncoding];
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitNetworkClient];
        
    }
    return self;
}
- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        
        [self customInitNetworkClient];
    }
    return self;
}
- (instancetype)initWithBaseURLString:(NSString *)urlString {
    if (self = [super initWithBaseURL:[NSURL URLWithString:urlString]]) {
        
        [self customInitNetworkClient];
    }
    return self;
}


#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API
#pragma mark Logging
- (void)logURLRequest:(NSURLRequest *)request method:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters {
    
    
    NSString *urlString = request.URL.absoluteString;
    
    // Headers
    NSMutableString *headerString = [[NSMutableString alloc] init];
    for (NSString *key in request.allHTTPHeaderFields.allKeys) {
        [headerString appendString:key];
        [headerString appendString:@":"];
        [headerString appendString:[[request.allHTTPHeaderFields objectForKey:key] stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
        [headerString appendString:@"\r"];
    }
    
    
    // Body
    NSString *bodyString = @"";
    if ([request.HTTPMethod isEqualToString:@"GET"] || [request.HTTPMethod isEqualToString:@"HEAD"] || [request.HTTPMethod isEqualToString:@"DELETE"]) {
        NSString *body = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
        if (!!body.length) {
            bodyString = body;
        }
    } else {
        NSError *error = nil;
        
        NSString *body = @"";
        
        if (!!parameters) {
            body = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:parameters options:(NSJSONWritingOptions)0 error:&error] encoding:NSUTF8StringEncoding];
            
            if (!!body.length) {
                bodyString = body;
            }
        }
    }
    
    NSString *jsonString = [NSString stringWithFormat:@"Request\r\r# URL:\r%@\r\r# METHOD:\r%@\r\r# HEADERS:\r%@\r# BODY:\r%@\r\r", urlString, method, headerString, bodyString];
    
    NSLog(@"%@", jsonString);
}



#pragma mark - Public API
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers {
    
    NSMutableURLRequest *request = [self requestWithMethod:method path:path parameters:parameters];
    
    [request setAllHTTPHeaderFields:RKDictionaryByMergingDictionaryWithDictionary(request.allHTTPHeaderFields, headers)];
    
    // Log Request
#ifdef DEBUG
    [self logURLRequest:request method:method path:path parameters:parameters];
#endif
    
    return request;
}


#pragma mark - Delegate Methods



@end
