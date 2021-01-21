//
//  GooglePlaceAPI.m
//  TruckYums
//
//  Created by Jayme Rutkoski on 1/18/21.
//  Copyright © 2021 truckyums. All rights reserved.
//

#import "GooglePlaceAPI.h"

// Delegates

// Utilities

// Globals

// Classes

// Classes - Models

// Classes - Views

// Classes - View Controllers

// Class Extensions

// Definitions


@interface GooglePlaceAPI ()

@property (strong, nonatomic) GooglePlacesRouter *router;

@end



@implementation GooglePlaceAPI


#pragma mark - Initialization
- (void)customInitGooglePlaceAPI {
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self customInitGooglePlaceAPI];
        self.router = [GooglePlacesRouter new];
    }
    return self;
}



#pragma mark - IBOutlets



#pragma mark - Properties



#pragma mark - Private API



#pragma mark - Public API
#pragma mark Nearby
- (void)searchNearby:(NSString *)keyword latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude radius:(NSNumber *)radius success:(void (^)(GooglePlacesNearby *))success failure:(void (^)(NSError *))failure {
    [self request:[self.router searchNearby:keyword latitude:latitude longitude:longitude radius:radius] parseIntoClass:[GooglePlacesNearby class] withKey:@"" success:^(GooglePlacesNearby *model) {
        if (!!success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (!!failure) {
            failure(error);
        }
    }];
}

#pragma mark Details
- (void)getPlaceDetails:(NSString *)placeID fields:(NSArray *)fields success:(void (^)(GooglePlacesDetails *))success failure:(void (^)(NSError *))failure {
    [self request:[self.router getPlaceDetails:placeID fields:fields] parseIntoClass:[GooglePlacesDetails class] withKey:@"" success:^(GooglePlacesDetails *model) {
        if (!!success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (!!failure) {
            failure(error);
        }
    }];
}

#pragma mark - Delegate Methods



@end
