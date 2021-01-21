//
//  GooglePlacesOpeningHours.h
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
#import "GooglePlacesPeriod.h"

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface GooglePlacesOpeningHours : NSObject


#pragma mark - Custom Delegates


#pragma mark - Initialization


#pragma mark - IBOutlets


#pragma mark - Properties
@property (nonatomic) BOOL openNow;
@property (strong, nonatomic) NSArray<GooglePlacesPeriod *> *periods;
@property (strong, nonatomic) NSArray<NSString *> *weekdayText;

#pragma mark - Public API



@end

@interface GooglePlacesOpeningHours (RKObjectMapping) <RKObjectMapping> @end
