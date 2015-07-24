//
//  KNConfiguration.m
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import "KNConfiguration.h"

// Server
NSString *const KNConfiguration_ServerURL             = @"http://127.0.0.1:8000/kindred_api/";
NSString *const KNConfiguration_CurrentChallengeURL   = @"http://127.0.0.1:8000/kindred_api/get_todays_challenge/";

// Instagram
NSString *const KNConfiguration_InstagramRedirectURL  = @"http://www.williamflaherty.com";
NSString *const KNConfiguration_InstagramClientID     = @"d4185dc0d84444b280b3466d009895a9";
NSString *const KNConfiguration_InstagramClientSecret = @"09d7937706ec41e39640b7c50dd467e0";
NSString *const KNConfiguration_InstagramAuthURL      = @"https://api.instagram.com/oauth/authorize/";
NSString *const KNConfiguration_InstagramAPIURL       = @"https://api.instagram.com/v1/users/";
