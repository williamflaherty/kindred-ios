//
//  PearingClient.h
//  Pearing App
//
//  Created by Nathan Ziebart on 1/19/14.
//  Copyright (c) 2014 Pearing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSONModel.h"
#import "KNStorage.h"
#import "KNTypes.h"
#import "KNInstagramService.h"

@interface KNClient : NSObject

@property (nonatomic) NSString *localUserName;

- (instancetype) initWithServerUrl:(NSString *)serverUrl
                        andStorage:(KNStorage*)storage;

// Registers a new user
//- (void) storeUser:(KNUser *)userInfo withType:(NSString*)callType andCompletion:(void (^)(KNUser *, NSError *))completion;

//- (KNUser *) updateUser:(KNUser *)userInfo;

- (void) getChallengeWithCompletion:(void (^)(KNChallengeInfo *, NSError *)) completionHandler;
- (void) storePhoto:(UIImage* )photo withCompletion:(void (^)(KNPhotoInfo *, NSError *)) completionHandler;
- (void) storeUserInfo:(KNInstagramUserInfo* )userInfo withCompletion:(void (^)(KNUserInfo *, NSError *)) completionHandler;


@end

