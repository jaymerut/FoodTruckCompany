//
//  NetworkController.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/19/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "NetworkController.h"

// Delegates

// Utilities

// Globals

// Classes

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface NetworkController ()

@property (strong, nonatomic) NSOperationQueue *operationQueue;

@end



@implementation NetworkController


#pragma mark - Initialization
- (void)customInitNetworkController {
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitNetworkController];
        
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties
- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [NSOperationQueue new];
    }
    return _operationQueue;
}



#pragma mark - Private API



#pragma mark - Public API
- (void)request:(NSURLRequest *)request parseIntoClass:(Class)klass withKey:(NSString *)key success:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    NSParameterAssert(success);
    
    [self.operationQueue addOperation:(NSOperation *)[NetworkManager request:request parseIntoClass:klass withKey:key success:success failure:failure]];
}


#pragma mark - Delegate Methods



@end
