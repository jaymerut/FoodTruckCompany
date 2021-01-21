//
//  NetworkController.h
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
#import "NetworkManager.h"

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface NetworkController : NSObject


#pragma mark - Custom Delegates


#pragma mark - Initialization


#pragma mark - IBOutlets


#pragma mark - Properties


#pragma mark - Public API
- (void)request:(NSURLRequest *)request parseIntoClass:(Class)klass withKey:(NSString *)key success:(void (^)(id))success failure:(void (^)(NSError *error))failure;


@end
