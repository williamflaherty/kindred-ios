//
//  KNConfiguration.m
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import "KNConfiguration.h"
// Server
NSString *const KNConfiguration_ServerURL             = @"http://192.168.0.41:8000/kindred_api/";
NSString *const KNConfiguration_CurrentChallengeURL   = @"http://192.168.0.41:8000/kindred_api/get_todays_challenge/";
NSString *const KNConfiguration_StorePhotoURL         = @"http://192.168.0.41:8000/kindred_api/store_photo/";
NSString *const KNConfiguration_StoreUserURL          = @"http://192.168.0.41:8000/kindred_api/store_user/";


// Instagram
NSString *const KNConfiguration_InstagramRedirectURL  = @"http://www.williamflaherty.com";
NSString *const KNConfiguration_InstagramClientID     = @"d4185dc0d84444b280b3466d009895a9";
NSString *const KNConfiguration_InstagramClientSecret = @"09d7937706ec41e39640b7c50dd467e0";
NSString *const KNConfiguration_InstagramAuthURL      = @"https://api.instagram.com/oauth/authorize/";
NSString *const KNConfiguration_InstagramAPIURL       = @"https://api.instagram.com/v1/users/";

// Storage Keys
NSString *const ChallengeInfoKey    = @"KNChallengeInfo";
NSString *const PhotoInfoKey        = @"KNPhotoInfo";
NSString *const IgUserInfoKey       = @"KNIgUserInfo";
NSString *const KNUserInfoKey       = @"KNUserInfo";
NSString *const UserIDKey           = @"KNIgUserId";
NSString *const AccessTokenKey      = @"KNIgAccessToken";
NSString *const UserTokenKey        = @"KNUserTokenKey";

