//
//  GooglePlacesNearby.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "GooglePlacesNearby.h"

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


@interface GooglePlacesNearby ()



@end


@implementation GooglePlacesNearby


#pragma mark - Initialization
- (void)customInitGooglePlacesNearby {
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitGooglePlacesNearby];
        
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API



#pragma mark - Public API



#pragma mark - Delegate Methods



@end

@implementation GooglePlacesNearby (RKObjectMapping)

- (NSDictionary *)attributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                            @"status":@"status"
                                           //@"results":@"results"
                                           }];
    
    return dictionary;
}
- (NSDictionary *)inverseAttributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                           @"status":@"status"
                                           //@"results":@"results"
                                           }];
    
    
    return dictionary;
}

- (NSArray *)relationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    RKRelationshipMapping *mapping_Results = [RKRelationshipMapping relationshipMappingFromKeyPath:@"results" toKeyPath:@"results" withMapping:[GooglePlacesResult mapping]];
    [array addObject:mapping_Results];
    
    // Superclass
    if ([self.superclass conformsToProtocol:@protocol(RKObjectMapping)] && [super respondsToSelector:@selector(relationshipMappings)]) {
        [array addObjectsFromArray:[super relationshipMappings]];
    }
    
    return array;
}
- (NSArray *)inverseRelationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    RKRelationshipMapping *mapping_Results = [RKRelationshipMapping relationshipMappingFromKeyPath:@"results" toKeyPath:@"results" withMapping:[GooglePlacesResult inverseMapping]];
    [array addObject:mapping_Results];
    
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
    return [[GooglePlacesNearby new] mapping];
}
+ (RKObjectMapping *)inverseMapping {
    return [[GooglePlacesNearby new] inverseMapping];
}


@end
