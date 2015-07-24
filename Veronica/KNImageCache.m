//
//  KNImageCache.m
//  Kindred
//
//  Created by Willie Flaherty on 7/20/15.
//  Copyright (c) 2015 Kindred. All rights reserved.
//

#import "KNImageCache.h"

@implementation KNImageCache {
    NSCache *_cache;
}

+ (id) instance {
    static KNImageCache *cache = nil;
    if (!cache) {
        cache = [KNImageCache new];
    }
    return cache;
}

- (id)init {
    self = [super init];
    _cache = [NSCache new];
    return self;
}

- (void)saveImage:(UIImage *)image key:(NSString *)key {
    [_cache setObject:image forKey:key];
}

- (UIImage *)imageForKey:(NSString *)key {
    return [_cache objectForKey:key];
}

- (BOOL)hasImageForKey:(NSString *)key {
    return [self imageForKey:key] != nil;
}

@end
