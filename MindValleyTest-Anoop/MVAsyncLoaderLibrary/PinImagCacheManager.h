//
//  PinImagCacheManager.h
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 09/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PinImagCacheManager : NSObject

@property (nonatomic, readonly, getter = isMemoryCacheEnabled) BOOL memoryCacheEnabled;

+ (instancetype)sharedInstance;
- (void)setCacheInMemory:(BOOL)enabled;
- (NSData *)imageDataByKey:(NSString *)key;
- (void)performWithImageData:(NSData *)imgData andKey:(NSString *)key;
@end
