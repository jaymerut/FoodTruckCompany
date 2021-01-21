//
//  GooglePlacesRouter.h
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
#import "NetworkRouter.h"

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface GooglePlacesRouter : NetworkRouter


#pragma mark - Custom Delegates


#pragma mark - Initialization


#pragma mark - IBOutlets


#pragma mark - Properties


#pragma mark - Public API
- (NSURLRequest *)searchNearby:(NSString *)keyword latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude radius:(NSNumber *)radius;

- (NSURLRequest *)getPlaceDetails:(NSString *)placeID fields:(NSArray *)fields;

@end
