//
//  NetworkRouter.h
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import <Foundation/Foundation.h>

// Delegates

// Utilities

// Globals

// Classes
#import "NetworkClient.h"

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface NetworkRouter : NSObject


#pragma mark - Custom Delegates


#pragma mark - Initialization
- (instancetype)initWithClient:(NetworkClient *)client;
- (instancetype)initWithClient:(NetworkClient *)client apiKey:(NSString *)apiKey;

#pragma mark - IBOutlets


#pragma mark - Properties
@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NetworkClient *client;


#pragma mark - Public API
- (NSURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters;
- (NSURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters headers:(NSDictionary *)headers;



@end
