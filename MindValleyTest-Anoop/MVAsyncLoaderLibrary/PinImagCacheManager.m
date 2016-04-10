//
//  PinImagCacheManager.m
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 09/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import "PinImagCacheManager.h"

@interface PinImagCacheManager() {
    NSCache *cache;
}

@end

@implementation PinImagCacheManager

+ (instancetype)sharedInstance
{
    static PinImagCacheManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        instance->cache = [NSCache new];
        instance->_memoryCacheEnabled = YES;
    });
    return instance;
}

- (NSData *)imageDataByKey:(NSString *)key {
    NSData *image = nil;
    if (_memoryCacheEnabled) {
        image = [cache objectForKey:key];
    }
    return image;
}

- (void)performWithImageData:(NSData *)imgData andKey:(NSString *)key {
    
    if (_memoryCacheEnabled) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            if (imgData) {
                [cache setObject:imgData forKey:key];
            }
        });
    }
    
}

#pragma mark - Cache

- (void)setCacheInMemory:(BOOL)enabled
{
    _memoryCacheEnabled = enabled;
}

@end
