//
//  NetworkOperation.h
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/19/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import <Foundation/Foundation.h>

// Delegates

// Utilities

// Globals

// Classes

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions

@class AFRKHTTPRequestOperation;

@interface NetworkOperation : NSOperation {
    
    BOOL _isFinished;
    BOOL _isExecuting;
}


#pragma mark - Custom Delegates


#pragma mark - Initialization
- (instancetype)initWithRequest:(NSURLRequest *)request;


#pragma mark - IBOutlets


#pragma mark - Properties
@property (nonatomic, assign) BOOL allowsInvalidSSLCertificate;

@property (nonatomic, assign) dispatch_queue_t successCallbackQueue;
@property (nonatomic, assign) dispatch_queue_t failureCallbackQueue;


#pragma mark - Public API
- (void)setCompletionBlockWithSuccess:(void (^)(AFRKHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFRKHTTPRequestOperation *operation, NSError *error))failure;



@end
