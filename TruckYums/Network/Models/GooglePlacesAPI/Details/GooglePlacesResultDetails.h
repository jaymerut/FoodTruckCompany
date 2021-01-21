//
//  GooglePlacesResultDetails.h
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
#import "GooglePlacesGeometry.h"
#import "GooglePlacesOpeningHours.h"

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface GooglePlacesResultDetails : NSObject


#pragma mark - Custom Delegates


#pragma mark - Initialization


#pragma mark - IBOutlets


#pragma mark - Properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *formattedPhoneNumber;
@property (strong, nonatomic) NSString *website;
@property (strong, nonatomic) NSArray<NSString *> *types;
@property (strong, nonatomic) GooglePlacesGeometry *geometry;
@property (strong, nonatomic) GooglePlacesOpeningHours *openingHours;

#pragma mark - Public API



@end

@interface GooglePlacesResultDetails (RKObjectMapping) <RKObjectMapping> @end
