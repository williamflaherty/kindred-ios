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
@property (nonatomic) NSNumber *completionCount;

@end

@interface KNUserInfo : JSONModel

- (instancetype) initWithUserDictionary:(NSDictionary *)dict;

@property (nonatomic) NSNumber *userPk;
@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *igToken;
@property (nonatomic) NSString *joinDate;

@end

@interface KNPhotoInfo : JSONModel

- (instancetype) initWithPhotoDictionary:(NSDictionary *)dict;

@property (nonatomic) NSString *url;
@property (nonatomic) NSNumber *challenge;
@property (nonatomic) NSNumber *user;
@property (nonatomic) NSString *pubDate;
@property (nonatomic) NSNumber *updoots;
@property (nonatomic) NSNumber *downvotes;
@property (nonatomic) BOOL      igShared;
@property (nonatomic) BOOL      flagged;
@property (nonatomic) NSString *city;
@property (nonatomic) BOOL      top_tf;

@end