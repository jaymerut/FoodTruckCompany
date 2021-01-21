//
//  GooglePlacesOpeningHours.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "GooglePlacesOpeningHours.h"

// Delegates

// Utilities
#import <RestKit/RestKit.h>

// Globals

// Classes

// Classes - Models
#import "GooglePlacesPeriod.h"

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface GooglePlacesOpeningHours ()



@end



@implementation GooglePlacesOpeningHours


#pragma mark - Initialization
- (void)customInitGooglePlacesOpeningHours {
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitGooglePlacesOpeningHours];
        
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API



#pragma mark - Public API



#pragma mark - Delegate Methods



@end

@implementation GooglePlacesOpeningHours (RKObjectMapping)

- (NSDictionary *)attributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                            @"open_now":@"openNow",
                                            //@"periods":@"periods",
                                            @"weekday_text":@"weekdayText"
                                            }];
    
    return dictionary;
}
- (NSDictionary *)inverseAttributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                            @"openNow":@"open_now",
                                            //@"periods":@"periods",
                                            @"weekdayText":@"weekday_text"
                                            }];
    
    return dictionary;
}

- (NSArray *)relationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    RKRelationshipMapping *mapping_Period = [RKRelationshipMapping relationshipMappingFromKeyPath:@"periods" toKeyPath:@"periods" withMapping:[GooglePlacesPeriod mapping]];
    [array addObject:mapping_Period];
    
    // Superclass
    if ([self.superclass conformsToProtocol:@protocol(RKObjectMapping)] && [super respondsToSelector:@selector(relationshipMappings)]) {
        [array addObjectsFromArray:[super relationshipMappings]];
    }

    return array;
}
- (NSArray *)inverseRelationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    RKRelationshipMapping *mapping_Period = [RKRelationshipMapping relationshipMappingFromKeyPath:@"periods" toKeyPath:@"periods" withMapping:[GooglePlacesPeriod inverseMapping]];
    [array addObject:mapping_Period];
    
    // Superclass
    if ([self.superclass conformsToProtocol:@protocol(RKObjectMapping)] && [super respondsToSelector:@selector(inverseRelationshipMappings)]) {
        [array addObjectsFromArray:[super inverseRelationshipMappings]];
    }

    return array;
}

- (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[self class]];
    
    [mapping addAttributeMappingsFromDictionary:[self attributeMappings]];
    
    [mapping addPropertyMappingsFromArray:[self relationshipMappings]];
    
    return mapping;
}
- (RKObjectMapping *)inverseMapping {
    RKObjectMapping *mapping = [[RKObjectMapping mappingForClass:[self class]] inverseMapping];
    
    [mapping addAttributeMappingsFromDictionary:[self inverseAttributeMappings]];
    
    [mapping addPropertyMappingsFromArray:[self inverseRelationshipMappings]];
    
    mapping.assignsDefaultValueForMissingAttributes = NO;
    
    return mapping;
}

+ (RKObjectMapping *)mapping {
    return [[GooglePlacesOpeningHours new] mapping];
}
+ (RKObjectMapping *)inverseMapping {
    return [[GooglePlacesOpeningHours new] inverseMapping];
}


@end
