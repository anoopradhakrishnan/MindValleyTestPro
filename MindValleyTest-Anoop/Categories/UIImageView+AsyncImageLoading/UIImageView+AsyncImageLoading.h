//
//  UIImageView+AsyncImageLoading.h
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 10/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AsyncImageLoading)
- (void) setImageFromUrl:(NSString*)urlString completion:(void (^)(void))completion;
@end
