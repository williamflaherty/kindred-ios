//
//  ImageCache.h
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h> 

@protocol ImageCache <NSObject>

- (void) saveImage:(UIImage *)image key:(NSString *)key;
- (UIImage *) imageForKey:(NSString *)key;
- (BOOL) hasImageForKey:(NSString *)key;

@end
