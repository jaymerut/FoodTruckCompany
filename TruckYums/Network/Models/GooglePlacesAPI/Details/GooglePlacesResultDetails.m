//
//  GooglePlacesResultDetails.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "GooglePlacesResultDetails.h"

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


@interface GooglePlacesResultDetails ()



@end



@implementation GooglePlacesResultDetails


#pragma mark - Initialization
- (void)customInitGooglePlacesResultDetails {
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitGooglePlacesResultDetails];
        
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API



#pragma mark - Public API



#pragma mark - Delegate Methods



@end

@implementation GooglePlacesResultDetails (RKObjectMapping)

- (NSDictionary *)attributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                            @"name":@"name",
                                            @"formatted_phone_number":@"formattedPhoneNumber",
                                            @"website":@"website",
                                            @"types":@"types"
                                            //@"geometry":@"geometry"
                                            //@"opening_hours":@"openingHours"
                                            }];
    
    return dictionary;
}
- (NSDictionary *)inverseAttributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary: @{
                                            @"name":@"name",
                                            @"formattedPhoneNumber":@"formatted_phone_number",
                                            @"website":@"website",
                                            @"types":@"types"
                                           //@"geometry":@"geometry",
                                           //@"openingHours":@"opening_hours"
                                           }];
   
    
    return dictionary;
}

- (NSArray *)relationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    RKRelationshipMapping *mapping_Geometry = [RKRelationshipMapping relationshipMappingFromKeyPath:@"geometry" toKeyPath:@"geometry" withMapping:[GooglePlacesGeometry mapping]];
    [array addObject:mapping_Geometry];
    
    RKRelationshipMapping *mapping_OpeningHours = [RKRelationshipMapping relationshipMappingFromKeyPath:@"opening_hours" toKeyPath:@"openingHours" withMapping:[GooglePlacesOpeningHours mapping]];
    [array addObject:mapping_OpeningHours];
    
    // Superclass
    if ([self.superclass conformsToProtocol:@protocol(RKObjectMapping)] && [super respondsToSelector:@selector(relationshipMappings)]) {
        [array addObjectsFromArray:[super relationshipMappings]];
    }
    
    return array;
}
- (NSArray *)inverseRelationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    RKRelationshipMapping *mapping_Geometry = [RKRelationshipMapping relationshipMappingFromKeyPath:@"geometry" toKeyPath:@"geometry" withMapping:[GooglePlacesGeometry inverseMapping]];
    [array addObject:mapping_Geometry];
    
    RKRelationshipMapping *mapping_OpeningHours = [RKRelationshipMapping relationshipMappingFromKeyPath:@"opening_hours" toKeyPath:@"openingHours" withMapping:[GooglePlacesOpeningHours inverseMapping]];
    [array addObject:mapping_OpeningHours];
    
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
    return [[GooglePlacesResultDetails new] mapping];
}
+ (RKObjectMapping *)inverseMapping {
    return [[GooglePlacesResultDetails new] inverseMapping];
}


@end
