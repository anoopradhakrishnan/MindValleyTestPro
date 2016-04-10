//
//  PinImageDownloader.m
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 09/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import "PinImageDownloader.h"
#import "PinImagCacheManager.h"
#import "NetworkManager.h"

@interface PinImageDownloader ()
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) PinImagCacheManager *cacheManager;
@end

@implementation PinImageDownloader

+ (PinImageDownloader *)sharedInstance{
    
    static PinImageDownloader* instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc] init];
        instance.operationQueue = [[NSOperationQueue alloc] init];
        instance.cacheManager =  [PinImagCacheManager sharedInstance];
    });
    return instance;
}

- (void)loadImageFromUrl:(NSString *)urlString Key:(NSString*)key completed:(void(^)(NSData *image))completed
                 failure:(void(^)(NSError *error))failure{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *cachedImage = [self.cacheManager imageDataByKey:urlString];
        if (cachedImage) {
            
            NSLog(@"cachedImage %@",urlString);
            if (completed) completed(cachedImage);
            return;
        }
    });

    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSOperation *operObj = [[NetworkManager alloc] initWithSession:self.URLSession URL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                [self.cacheManager performWithImageData:data andKey:urlString];
                if (completed) completed(data);
            } else if (error){
                if (failure) failure(error);
            }
        });
    }];
    
    [operObj setName:key];
    
    [[self operationQueue] addOperation:operObj];

}

- (void)stopDataLoading:(NSString*)key{
    for (NetworkManager *operation in self.operationQueue.operations) {
        if ([operation.name isEqualToString:key]) {
            [operation cancel];
        }
    }
}

@end


@implementation PinImageDownloader (Subclassing)

- (NSURLSession*)URLSession
{
    return [NSURLSession sharedSession];
}


@end
