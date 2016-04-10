//
//  UIImageView+AsyncImageLoading.m
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 10/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import "UIImageView+AsyncImageLoading.h"
#import "PinImageDownloader.h"

@implementation UIImageView (AsyncImageLoading)

- (void) setImageFromUrl:(NSString*)urlString completion:(void (^)(void))completion{
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[PinImageDownloader sharedInstance] loadImageFromUrl:urlString Key:[NSString stringWithFormat:@"%ld",(long)self.tag] completed:^(NSData *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image  = [UIImage imageWithData:image];
            });
            dispatch_async(dispatch_get_main_queue(), completion);

        } failure:^(NSError *error){
            NSLog(@"loadImageFromUrl error : %@",error);
        }];
        
    });
}
@end
