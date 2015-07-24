//
//  KNImageCache.h
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 
#import "ImageCache.h"

@interface KNImageCache : NSObject <ImageCache>

+ (instancetype) instance;

@end
