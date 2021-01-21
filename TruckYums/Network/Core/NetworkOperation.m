//
//  NetworkOperation.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/19/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "NetworkOperation.h"

// Delegates

// Utilities
#import <RestKit/RestKit.h>

// Globals

// Classes

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface NetworkOperation ()

@property (strong, nonatomic) AFRKJSONRequestOperation *operation;

@property (nonatomic) BOOL isAsynchronouse;

@end



@implementation NetworkOperation


#pragma mark - Initialization
- (void)customInitNetworkOperation {
    _isExecuting = NO;
    _isFinished = NO;
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitNetworkOperation];
        
    }
    return self;
}

- (instancetype)initWithRequest:(NSURLRequest *)request {
    if (self = [super init]) {
        [self customInitNetworkOperation];
        
        _operation = [[AFRKJSONRequestOperation alloc] initWithRequest:request];
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties
- (BOOL)allowsInvalidSSLCertificate {
    return self.operation.allowsInvalidSSLCertificate;
}
- (void)setAllowsInvalidSSLCertificate:(BOOL)allowsInvalidSSLCertificate {
    self.operation.allowsInvalidSSLCertificate = allowsInvalidSSLCertificate;
}

- (dispatch_queue_t)successCallbackQueue {
    return self.operation.successCallbackQueue;
}
- (void)setSuccessCallbackQueue:(dispatch_queue_t)successCallbackQueue {
    self.operation.successCallbackQueue = successCallbackQueue;
}
- (dispatch_queue_t)failureCallbackQueue {
    return self.operation.failureCallbackQueue;
}
- (void)setFailureCallbackQueue:(dispatch_queue_t)failureCallbackQueue {
    self.operation.failureCallbackQueue = failureCallbackQueue;
}


#pragma mark - Private API
- (void)updateIsFinished:(BOOL)value {
    [self willChangeValueForKey:@"isFinished"];
    _isFinished = value;
    [self didChangeValueForKey:@"isFinished"];
}
- (void)updateIsExecuting:(BOOL)value {
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = value;
    [self didChangeValueForKey:@"isExecuting"];
}


#pragma mark - Public API
- (void)start {
    
    if (self.isCancelled) {
        [self updateIsFinished:YES];
        return;
    }
    
    
    [self updateIsExecuting:YES];
    
    
    [self.operation start];
}
- (void)finish {
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _isExecuting = NO;
    _isFinished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}
- (void)cancel {
    [self.operation cancel];
    
    [super cancel];
}


- (BOOL)isExecuting {
    return _isExecuting;
}

- (BOOL)isFinished {
    return _isFinished;
}


- (void)setCompletionBlockWithSuccess:(void (^)(AFRKHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFRKHTTPRequestOperation *operation, NSError *error))failure {
    
    __weak typeof(self) wself = self;
    [self.operation setCompletionBlockWithSuccess:^(AFRKHTTPRequestOperation *operation, id responseObject) {
        __strong typeof(wself) sself = wself;
        
        [sself finish];
        
        if (!operation.isCancelled && !self.isCancelled) {
            if (!!success) {
                success(operation, responseObject);
            }
        }
    } failure:^(AFRKHTTPRequestOperation *operation, NSError *error) {
        __strong typeof(wself) sself = wself;
        
        [sself finish];
        
        if (!operation.isCancelled && !self.isCancelled) {
            if (!!failure) {
                failure(operation, error);
            }
        }
    }];
}



#pragma mark - Delegate Methods



@end
