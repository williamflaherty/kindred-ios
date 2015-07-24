//
//  KNStorage.h
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNStorage : NSObject

- (void) setObject:(id)object forKey:(NSString *)key;
- (id) objectForKey:(NSString *)key;

@end
