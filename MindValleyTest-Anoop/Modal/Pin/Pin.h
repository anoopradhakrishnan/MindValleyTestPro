//
//  Pin.h
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 10/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pin : NSObject

@property(nonatomic,strong) NSString *pinImageURL;
+(Pin*)getPinData:(NSDictionary*)dict;
@end
