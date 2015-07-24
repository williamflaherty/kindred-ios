//
//  PearingClient.m
//  Pearing App
//
//  Created by Nathan Ziebart on 1/19/14.
//  Copyright (c) 2014 Pearing. All rights reserved.
//

#import "KNConfiguration.h" //for some reason when I include this file I get multiple definition erros and I just didn't feel like trying to figure out why. If we do figure it out we can just replace the string down there with the actual API call.
#import "KNClient.h"
#import "KNContainer.h"
#import "KNStorage.h"

static NSString *const ChallengeInfoKey = @"KNChallengeInfo";

@implementation KNClient {
    NSString *_serverURL;
    KNStorage *_storage;
}

- (instancetype)initWithServerUrl:(NSString *)serverUrl
                    andStorage:(KNStorage *)storage{
    self = [super init];
    
    _serverURL = serverUrl;
    _storage = storage;
    
    return self;
}

- (NSOperationQueue *) operationQueue {
    static NSOperationQueue *queue = nil;
    if (!queue) {
        queue = [NSOperationQueue new];
    }
    return queue;
}

- (void) getChallengeWithCompletion:(void (^)(KNChallengeInfo *, NSError *)) completionHandler {
    
    NSString *url = [NSString stringWithFormat:@"%@", KNConfiguration_CurrentChallengeURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error getting user info: %@", error);
            
            completionHandler(nil, error);
            return;
        }
        
        @try
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            KNChallengeInfo *challengeInfo = [[KNChallengeInfo alloc] initWithChallengeDictionary:json[@"data"]];
            
            [_storage setObject:[challengeInfo toDictionary] forKey:ChallengeInfoKey];
            
            completionHandler(challengeInfo, nil);
        }
        @catch (NSException *exception)
        {
            NSLog(@"Error parsing user info: %@", exception);
            
            completionHandler(nil, [NSError errorWithDomain:@"com.kindred" code:-1 userInfo:@{@"Message" : @"Unable to parse response"}]);
        }
    }];

}


@end

@implementation KNChallengeInfo

- (instancetype) initWithChallengeDictionary:(NSDictionary *)dict{
    self = [super init];
    
    self.challenge = dict[@"curr_challenge"][@"challenge"];
    self.date = dict[@"curr_challenge"][@"pub_date"];
    self.completion_count = (int)[dict[@"curr_challenge"][@"completions"] integerValue];
    
    return self;
}

@end
