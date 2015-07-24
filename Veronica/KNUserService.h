//
//  KNService.h
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KNClient.h"
#import "KNStorage.h"
#import "JSONModel.h"

@interface KNUserService : NSObject

@property (nonatomic, readonly) BOOL isRegistered;

- (instancetype) initWithAPIClient:(KNClient *)client
                           storage:(KNStorage *)storage;

- (BOOL) isUserLoggedIn;
- (NSString *) userToken;
//- (KNUser *) userInfo;
//- (void)registerUser:(KNUser *)person withCompletion:(void (^)(KNUser *, NSError *))completion;
//- (void)updateUser:(KNUser *)person withCompletion:(void (^)(KNUser *, NSError *))completion;

@end

