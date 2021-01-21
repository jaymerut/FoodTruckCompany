//
//  GooglePlaceAPI.h
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
#import "NetworkController.h"
#import "GooglePlacesRouter.h"

// Classes - Models
#import "GooglePlacesNearby.h"
#import "GooglePlacesDetails.h"

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface GooglePlaceAPI : NetworkController


#pragma mark - Custom Delegates


#pragma mark - Initialization


#pragma mark - IBOutlets


#pragma mark - Properties


#pragma mark - Public API
#pragma mark Nearby
- (void)searchNearby:(NSString *)keyword latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude radius:(NSNumber *)radius success:(void (^)(GooglePlacesNearby *))success failure:(void (^)(NSError *))failure;

#pragma mark Details
- (void)getPlaceDetails:(NSString *)placeID fields:(NSArray *)fields success:(void (^)(GooglePlacesDetails *))success failure:(void (^)(NSError *))failure;

@end
