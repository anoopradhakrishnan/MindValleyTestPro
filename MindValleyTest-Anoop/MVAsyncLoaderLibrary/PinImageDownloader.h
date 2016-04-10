//
//  PinImageDownloader.h
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 09/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinImageDownloader : NSObject

+ (PinImageDownloader *)sharedInstance;
- (void)loadImageFromUrl:(NSString *)urlString Key:(NSString*)key completed:(void(^)(NSData *image))completed
                 failure:(void(^)(NSError *error))failure;
- (void)stopDataLoading:(NSString*)key;
@end

@interface PinImageDownloader (Subclassing)
@property (nonatomic, readonly) NSURLSession *URLSession;
@end