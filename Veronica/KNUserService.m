//
//  KNService.m
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import "KNConfiguration.h"
#import "KNUserService.h"
//#import "PEUser.h"

@implementation KNUserService {
    KNClient *_apiClient;
    KNStorage *_storage;
}

- (id)initWithAPIClient:(KNClient *)client storage:(KNStorage *)storage {
    self = [super init];
    
    _apiClient = client;
    _storage = storage;
    
    return self;
}

- (BOOL)isUserLoggedIn {
    return self.userToken != nil;
}

- (NSString *)userToken {
    return [_storage objectForKey:UserTokenKey];
}

@end


