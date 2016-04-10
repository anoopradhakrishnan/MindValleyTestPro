//
//  Pin.m
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 10/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import "Pin.h"

@implementation Pin

+(Pin*)getPinData:(NSDictionary*)dict;{
    
    Pin *pin = [Pin new];
    pin.pinImageURL = [[[dict objectForKey:@"images"] objectForKey:@"237x"] objectForKey:@"url"];
    return pin;
}

@end
