//
//  NetworkManager.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/19/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "NetworkManager.h"

// Delegates

// Protocols
#import "RKObjectMappingProtocol.h"

// Utilities
#import <RestKit/RestKit.h>

// Globals

// Classes
#import "NetworkOperation.h"

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface NetworkManager ()



@end



@implementation NetworkManager


#pragma mark - Initialization
- (void)customInitNetworkManager {
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitNetworkManager];
        
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API



#pragma mark - Public API
+ (NetworkOperation *)request:(NSURLRequest *)request parseIntoClass:(Class)klass withKey:(NSString *)key success:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    NSParameterAssert(success);
    
    NetworkOperation *operation = [[NetworkOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFRKHTTPRequestOperation *operation, id responseObject) {
        
        NSAssert([klass conformsToProtocol:@protocol(RKObjectMapping)], @"The class [%@] does not conform to the protocol <RKObjectMapping>", NSStringFromClass(klass));
        
        NSDictionary *mappingsDictionary;
        
        if (!!key.length) {
            mappingsDictionary = @{key:[klass mapping]};
        } else {
            mappingsDictionary = @{[NSNull null]:[klass mapping]};
        }
        
        NSArray *jsonDictionaries = responseObject;
        id object = nil;
        
        RKMapperOperation *mapperOperation = [[RKMapperOperation alloc] initWithRepresentation:jsonDictionaries mappingsDictionary:mappingsDictionary];
        
        
        NSError *errorMapping = nil;
        BOOL isMapped = [mapperOperation execute:&errorMapping];
        
        if (isMapped && !errorMapping) {
            object = mapperOperation.mappingResult.array.firstObject;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                success(object);
            }
        });
    } failure:^(AFRKHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(error);
            }
        });
    }];
    
    operation.allowsInvalidSSLCertificate = YES;
    
    // Use a background queue so JSON results are parsed off the UI thread. We'll dispatch back to main queue on success.
    operation.successCallbackQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    return operation;
}


#pragma mark - Delegate Methods



@end
