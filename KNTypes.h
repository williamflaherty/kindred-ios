//
//  KNTypes.h
//  Veronica
//
//  Created by Dwayne Flaherty on 7/25/15.
//  Copyright (c) 2015 Willie Flaherty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "KNStorage.h"

@interface KNChallengeInfo : JSONModel

- (instancetype) initWithChallengeDictionary:(NSDictionary *)dict;

@property (nonatomic) NSNumber *challengePk;
@property (nonatomic) NSString *challenge;
@property (nonatomic) NSString *date;
@property (nonatomic) int completionCount;

@end

@interface KNUserInfo : JSONModel

- (instancetype) initWithUserDictionary:(NSDictionary *)dict;

@property (nonatomic) NSNumber *userPk;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *igToken;
@property (nonatomic) NSString *joinDate;

@end

@interface KNPhotoInfo : JSONModel

- (instancetype) initWithPhotoDictionary:(NSDictionary *)dict
                             andUserInfo:(KNUserInfo*)userInfo
                        andChallengeInfo:(KNChallengeInfo *)challengeInfo;

@property (nonatomic) NSString *url;
@property (nonatomic) KNChallengeInfo *challenge;
@property (nonatomic) KNUserInfo *user;
@property (nonatomic) NSString *pubDate;
@property (nonatomic) int updoots;
@property (nonatomic) int downvotes;
@property (nonatomic) BOOL igShared;
@property (nonatomic) BOOL flagged;
@property (nonatomic) NSString *city;
@property (nonatomic) BOOL top_tf;

@end