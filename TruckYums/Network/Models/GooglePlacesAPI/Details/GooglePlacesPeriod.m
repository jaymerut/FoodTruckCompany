//
//  GooglePlacesPeriod.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "GooglePlacesPeriod.h"

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


@interface GooglePlacesPeriod ()



@end



@implementation GooglePlacesPeriod


#pragma mark - Initialization
- (void)customInitGooglePlacesPeriod {
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitGooglePlacesPeriod];
        
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API



#pragma mark - Public API



#pragma mark - Delegate Methods



@end

@implementation GooglePlacesPeriod (RKObjectMapping)

- (NSDictionary *)attributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                           //@"close":@"close"
                                           //@"open":@"open"
                                           }];
    
    return dictionary;
}
- (NSDictionary *)inverseAttributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                           //@"close":@"close"
                                           //@"open":@"open"
                                           }];
    
    
    return dictionary;
}

- (NSArray *)relationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    RKRelationshipMapping *mapping_Close = [RKRelationshipMapping relationshipMappingFromKeyPath:@"close" toKeyPath:@"close" withMapping:[GooglePlacesClose mapping]];
    [array addObject:mapping_Close];
    
    RKRelationshipMapping *mapping_Open = [RKRelationshipMapping relationshipMappingFromKeyPath:@"open" toKeyPath:@"open" withMapping:[GooglePlacesClose mapping]];
    [array addObject:mapping_Open];
    
    // Superclass
    if ([self.superclass conformsToProtocol:@protocol(RKObjectMapping)] && [super respondsToSelector:@selector(relationshipMappings)]) {
        [array addObjectsFromArray:[super relationshipMappings]];
    }
    
    return array;
}
- (NSArray *)inverseRelationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    RKRelationshipMapping *mapping_Close = [RKRelationshipMapping relationshipMappingFromKeyPath:@"close" toKeyPath:@"close" withMapping:[GooglePlacesClose inverseMapping]];
    [array addObject:mapping_Close];
    
    RKRelationshipMapping *mapping_Open = [RKRelationshipMapping relationshipMappingFromKeyPath:@"open" toKeyPath:@"open" withMapping:[GooglePlacesClose inverseMapping]];
    [array addObject:mapping_Open];
    
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
    return [[GooglePlacesPeriod new] mapping];
}
+ (RKObjectMapping *)inverseMapping {
    return [[GooglePlacesPeriod new] inverseMapping];
}


@end
