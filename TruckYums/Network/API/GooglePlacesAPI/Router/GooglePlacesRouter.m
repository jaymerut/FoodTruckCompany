//
//  GooglePlacesRouter.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "GooglePlacesRouter.h"

// Delegates

// Utilities

// Globals

// Classes

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface GooglePlacesRouter ()



@end



@implementation GooglePlacesRouter


#pragma mark - Initialization
- (void)customInitGooglePlacesRouter {
    
}
- (instancetype)init {
    return [super initWithClient:[GooglePlacesRouter defaultClient]];
}

- (instancetype)initWithClient:(NetworkClient *)client {
    return [super initWithClient:client];
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API
+ (NetworkClient *)defaultClient {
    return [[NetworkClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
}


#pragma mark - Public API
- (NSURLRequest *)searchNearby:(NSString *)keyword latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude radius:(NSNumber *)radius {
    
    NSString *method = @"GET";
    
    
    // Path
    NSString *path = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json";
    
    // Parameters
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"location"] = [NSString stringWithFormat:@"%@,%@", latitude.stringValue, longitude.stringValue];
    parameters[@"radius"] = radius.stringValue;
    parameters[@"keyword"] = keyword;
    parameters[@"key"] = @"AIzaSyBXzn94W_bBU0-DarSLbSyJ8w7jBI6MeMI";
    
    // Request
    return [self requestWithMethod:method path:path parameters:parameters headers:[NSDictionary new]];
}

- (NSURLRequest *)getPlaceDetails:(NSString *)placeID fields:(NSArray *)fields {
    
    NSString *method = @"GET";
    
    NSString *fieldsString = @"";
    for (NSString *value in fields) {
        if (fieldsString.length == 0) {
            fieldsString = value;
        } else {
            fieldsString = [NSString stringWithFormat:@"%@,%@", fieldsString, value];
        }
    }
    
    // Path
    NSString *path = @"https://maps.googleapis.com/maps/api/place/details/json";
    
    // Parameters
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"place_id"] = placeID;
    parameters[@"fields"] = fieldsString;
    parameters[@"key"] = @"AIzaSyBXzn94W_bBU0-DarSLbSyJ8w7jBI6MeMI";
    
    // Request
    return [self requestWithMethod:method path:path parameters:parameters headers:[NSDictionary new]];
}


#pragma mark - Delegate Methods



@end
