//
//  GooglePlacesResult.h
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

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface GooglePlacesResult : NSObject


#pragma mark - Custom Delegates


#pragma mark - Initialization


#pragma mark - IBOutlets


#pragma mark - Properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *placeID;
@property (strong, nonatomic) NSString *reference;

#pragma mark - Public API



@end

@interface GooglePlacesResult (RKObjectMapping) <RKObjectMapping> @end
