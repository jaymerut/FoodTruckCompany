//
//  NetworkClient.h
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import <Foundation/Foundation.h>

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


@interface NetworkClient : AFRKHTTPClient


#pragma mark - Custom Delegates


#pragma mark - Initialization
- (instancetype)initWithBaseURLString:(NSString *)urlString;

#pragma mark - IBOutlets


#pragma mark - Properties


#pragma mark - Public API
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers;


@end
