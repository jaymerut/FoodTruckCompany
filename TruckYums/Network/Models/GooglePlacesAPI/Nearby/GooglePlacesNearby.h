//
//  GooglePlacesNearby.h
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import <Foundation/Foundation.h>

// Delegates

// Utilities
#import "RKObjectMappingProtocol.h"

// Globals

// Classes

// Classes - Models
#import "GooglePlacesResult.h"

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface GooglePlacesNearby : NSObject


#pragma mark - Custom Delegates


#pragma mark - Initialization


#pragma mark - IBOutlets


#pragma mark - Properties
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSArray<GooglePlacesResult *> *results;

#pragma mark - Public API



@end

@interface GooglePlacesNearby (RKObjectMapping) <RKObjectMapping> @end
