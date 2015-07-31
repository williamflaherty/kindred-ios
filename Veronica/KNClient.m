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
#import "KNInstagramService.h"
#import "KNTypes.h"

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
            
            completionHandler(nil, [NSError errorWithDomain:@"com.kindred" code:-1 userInfo:@{@"Message" : @"Unable to parse response from kindred server:get_challenge"}]);
        }
    }];

}

- (void) storeUserInfo:(KNInstagramUserInfo* )userInfo withCompletion:(void (^)(KNUserInfo *, NSError *)) completionHandler {
    NSMutableDictionary *requestData = [[NSMutableDictionary alloc] init];
    NSDate *currDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@", dateString);
    [requestData setValue:userInfo.username forKey:@"username"];
    [requestData setValue:[_storage objectForKey:AccessTokenKey] forKey:@"ig_token"];
    [requestData setValue:dateString forKey:@"join_date"];
    
    NSString *url = [NSString stringWithFormat:@"%@", KNConfiguration_StoreUserURL];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];

    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error getting user info: %@", error);
            
            completionHandler(nil, error);
            return;
        }
        
        @try
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //are we actually storing the PK here?
            KNUserInfo *userInfo = [[KNUserInfo alloc] initWithUserDictionary:json[@"data"]];
            NSLog(@"Look we made it back and are storing user info:%@", userInfo);
            [_storage setObject:[userInfo toDictionary] forKey:KNUserInfoKey];
            
            completionHandler(userInfo, nil);
        }
        @catch (NSException *exception)
        {
            NSLog(@"Error parsing user info: %@", exception);
            
            completionHandler(nil, [NSError errorWithDomain:@"com.kindred" code:-1 userInfo:@{@"Message" : @"Unable to parse response from kindred server:store_user"}]);
        }
    }];

    
}

- (void) storePhoto:(UIImage* )photo withCompletion:(void (^)(KNPhotoInfo *, NSError *)) completionHandler {
    
    
    NSString *FileParamConstant = @"file";
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    NSString *url = [NSString stringWithFormat:@"%@", KNConfiguration_StorePhotoURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSMutableDictionary *photo_dict = [[NSMutableDictionary alloc] init];
    NSDate *currDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSLog(@"%@", dateString);
    NSMutableDictionary *userInfo = [_storage objectForKey:KNUserInfoKey];
    NSMutableDictionary *challengeInfo = [_storage objectForKey:ChallengeInfoKey];
    
    NSLog(@"%@", userInfo[@"userName"]);
    //setup the post.DATA
    [photo_dict setObject:@"url" forKey:@"url"];
    [photo_dict setObject:challengeInfo[@"challengePk"] forKey:@"challenge"];
    [photo_dict setObject:userInfo[@"userPk"] forKey:@"user"];
    [photo_dict setObject:dateString forKey:@"pub_date"];
    [photo_dict setObject:@"1" forKey:@"updoots"];
    [photo_dict setObject:@"0" forKey:@"downvotes"];
    [photo_dict setObject:@"0" forKey:@"ig_shared"];
    [photo_dict setObject:@"0" forKey:@"flagged"];
    //get current location
    [photo_dict setObject:@"city" forKey:@"city"];
    [photo_dict setObject:@"0" forKey:@"top_tf"];
    
    //setup the request parameters
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    //set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in photo_dict) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [photo_dict objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(photo, 1.0);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error getting user info: %@", error);
            
            completionHandler(nil, error);
            return;
        }
        
        @try
        {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            BOOL valid = [[json objectForKey:@"success"]boolValue];
            if (valid) {
                /*this code works but for some reason the debugger shows nothing in the photo info object, no idea wtf apple wtf */
                KNPhotoInfo *photoInfo = [[KNPhotoInfo alloc] initWithPhotoDictionary:json[@"data"]];
                
                [_storage setObject:[photoInfo toDictionary] forKey:PhotoInfoKey];
                
                //NSLog(@"%@", [photoInfo toDictionary]);
                completionHandler(photoInfo, nil);
            } else{
                completionHandler(nil, [NSError errorWithDomain:@"com.kindred" code:-1 userInfo:@{@"Message" : @"You're trying to submit two photos in a day. Naughty. Naughty."}]);
            }
        }
        @catch (NSException *exception)
        {
            NSLog(@"Error parsing user info: %@", exception);
            
            completionHandler(nil, [NSError errorWithDomain:@"com.kindred" code:-1 userInfo:@{@"Message" : @"Unable to parse response from kindred server:store_photo"}]);
        }
    }];

}

@end


