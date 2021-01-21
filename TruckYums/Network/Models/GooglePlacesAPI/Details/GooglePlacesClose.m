//
//  GooglePlacesClose.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "GooglePlacesClose.h"

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


@interface GooglePlacesClose ()



@end



@implementation GooglePlacesClose


#pragma mark - Initialization
- (void)customInitGooglePlacesClose {
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitGooglePlacesClose];
        
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API



#pragma mark - Public API



#pragma mark - Delegate Methods



@end

@implementation GooglePlacesClose (RKObjectMapping)

- (NSDictionary *)attributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                            @"day":@"day",
                                            @"time":@"time"
                                           }];
    
    return dictionary;
}
- (NSDictionary *)inverseAttributeMappings {
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary addEntriesFromDictionary:@{
                                           @"day":@"day",
                                           @"time":@"time"
                                           }];
    
    
    return dictionary;
}

- (NSArray *)relationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    // Superclass
    if ([self.superclass conformsToProtocol:@protocol(RKObjectMapping)] && [super respondsToSelector:@selector(relationshipMappings)]) {
        [array addObjectsFromArray:[super relationshipMappings]];
    }
    
    return array;
}
- (NSArray *)inverseRelationshipMappings {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
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
    return [[GooglePlacesClose new] mapping];
}
+ (RKObjectMapping *)inverseMapping {
    return [[GooglePlacesClose new] inverseMapping];
}


@end
