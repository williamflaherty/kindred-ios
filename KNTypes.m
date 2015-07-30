//
//  KNTypes.m
//  Veronica
//
//  Created by Dwayne Flaherty on 7/25/15.
//  Copyright (c) 2015 Willie Flaherty. All rights reserved.
//

#import "KNTypes.h"

@implementation KNChallengeInfo

- (instancetype) initWithChallengeDictionary:(NSDictionary *)dict{
    self = [super init];
    
    self.challengePk        = dict[@"curr_challenge"][@"id"];
    self.challenge          = dict[@"curr_challenge"][@"challenge"];
    self.date               = dict[@"curr_challenge"][@"pub_date"];
    self.completionCount    = (int)[dict[@"curr_challenge"][@"completions"] integerValue];
    
    return self;
}

@end


@implementation KNUserInfo

- (instancetype) initWithUserDictionary:(NSDictionary *)dict{
    self = [super init];
    NSLog(@"%@", dict);
    self.userPk             = dict[@"user"][@"id"];
    self.userName           = dict[@"user"][@"username"];
    self.igToken            = dict[@"user"][@"ig_token"];
    self.joinDate           = dict[@"user"][@"join_date"];
    
    return self;
}

@end

@implementation KNPhotoInfo

- (instancetype) initWithPhotoDictionary:(NSDictionary *)dict
                             andUserInfo:(KNUserInfo*)userInfo
                        andChallengeInfo:(KNChallengeInfo *)challengeInfo{
    self = [super init];
    
    self.url                = dict[@"photo"][@"url"];
    self.challenge          = challengeInfo;
    self.user               = userInfo;
    self.pubDate            = dict[@"photo"][@"pub_date"];
    self.updoots            = (int)dict[@"photo"][@"updoots"];
    self.downvotes          = (int)dict[@"photo"][@"downvotes"];
    self.igShared           = (BOOL)dict[@"photo"][@"ig_shared"];
    self.flagged            = (BOOL)dict[@"photo"][@"flagged"];
    self.city               = dict[@"photo"][@"city"];
    self.top_tf             = (BOOL)dict[@"photo"][@"top_tf"];

    
    return self;
}

@end

