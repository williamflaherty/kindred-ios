//
//  KNContainer.m
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import "KNContainer.h"
#import "KNConfiguration.h"

@implementation KNContainer

+ (KNClient *)APIClient {
    static KNClient *client;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[KNClient alloc] initWithServerUrl:KNConfiguration_ServerURL
                                    andStorage:[self storage]];
    });
    
    return client;
}

+ (KNStorage *)storage {
    static KNStorage *storage;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storage = [[KNStorage alloc] init];
    });
    
    return storage;
}

+ (KNInstagramService *)instagramService {
    static KNInstagramService *service;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[KNInstagramService alloc]
                   initWithAuthURL:KNConfiguration_InstagramAuthURL
                   apiURL:KNConfiguration_InstagramAPIURL
                   clientID:KNConfiguration_InstagramClientID
                   clientSecret:KNConfiguration_InstagramClientSecret
                   redirectURL:KNConfiguration_InstagramRedirectURL
                   storage:[self storage]];
    });
    
    return service;
}

+ (KNUserService *)kindredService {
    static KNUserService *service;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[KNUserService alloc]
                   initWithAPIClient:[self APIClient]
                   storage:[self storage]
                   ];
    });
    
    return service;
}

+ (id<ImageCache>)imageCache {
    return [KNImageCache instance];
}

@end
