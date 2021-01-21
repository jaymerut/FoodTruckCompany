//
//  RKObjectMapping.h
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import <Foundation/Foundation.h>

// Delegates

// Utilities

// Globals

// Classes

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@class RKObjectMapping;

@protocol RKObjectMapping <NSObject>

@required
- (NSDictionary *)attributeMappings;
- (NSDictionary *)inverseAttributeMappings;

- (NSArray *)relationshipMappings;
- (NSArray *)inverseRelationshipMappings;

- (RKObjectMapping *)mapping;
- (RKObjectMapping *)inverseMapping;

+ (RKObjectMapping *)mapping;
+ (RKObjectMapping *)inverseMapping;

@end

@interface NSObject (RKObjectMappingEmptyMethods)

- (NSDictionary *)attributeMappings;
- (NSDictionary *)inverseAttributeMappings;

- (NSArray *)relationshipMappings;
- (NSArray *)inverseRelationshipMappings;

@end
