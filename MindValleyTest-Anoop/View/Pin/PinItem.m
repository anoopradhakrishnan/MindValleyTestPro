//
//  PinItem.m
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 09/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import "PinItem.h"
#import "PinImageDownloader.h"

@implementation PinItem

- (void)awakeFromNib {
    // Initialization code
}

- (void)prepareForReuse
{
    PinImageDownloader *objMng = [PinImageDownloader sharedInstance];
    [objMng stopDataLoading:[NSString stringWithFormat:@"%ld",(long)self.pinImageVIew.tag]];
    self.pinImageVIew.image = nil;
}

@end
