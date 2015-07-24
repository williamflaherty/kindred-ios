//
//  KNContainer.h
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNClient.h"
#import "KNStorage.h"
#import "KNInstagramService.h"
#import "KNImageCache.h"
#import "KNUserService.h"

@interface KNContainer : NSObject

+ (KNClient *) APIClient;

+ (KNStorage *) storage;

+ (KNInstagramService *) instagramService;

+ (KNUserService *)kindredService;

+ (id<ImageCache>) imageCache;

@end
