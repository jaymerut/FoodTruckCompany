//
//  GooglePlacesGeometry.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "GooglePlacesGeometry.h"

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


@interface GooglePlacesGeometry ()



@end



@implementation GooglePlacesGeometry


#pragma mark - Initialization
- (void)customInitGooglePlacesGeometry {
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitGooglePlacesGeometry];
        
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API



#pragma mark - Public API



#pragma mark - Delegate Methods



@end

@implementation GooglePlacesGeometry (RKObjectMapping)

- (NSDictionary *)attributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                           //@"location":@"location"
                                           }];
    
    return dictionary;
}
- (NSDictionary *)inverseAttributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                           //@"location":@"location"
                                           }];
    
    
    return dictionary;
}

- (NSArray *)relationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    RKRelationshipMapping *mapping_Location = [RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:[GooglePlacesLocation mapping]];
    [array addObject:mapping_Location];

    // Superclass
    if ([self.superclass conformsToProtocol:@protocol(RKObjectMapping)] && [super respondsToSelector:@selector(relationshipMappings)]) {
        [array addObjectsFromArray:[super relationshipMappings]];
    }
    
    return array;
}
- (NSArray *)inverseRelationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    RKRelationshipMapping *mapping_Location = [RKRelationshipMapping relationshipMappingFromKeyPath:@"location" toKeyPath:@"location" withMapping:[GooglePlacesLocation inverseMapping]];
    [array addObject:mapping_Location];

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
    return [[GooglePlacesGeometry new] mapping];
}
+ (RKObjectMapping *)inverseMapping {
    return [[GooglePlacesGeometry new] inverseMapping];
}


@end
