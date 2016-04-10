//
//  NetworkManager.h
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 09/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSOperation

@property (nonatomic, strong, readonly) NSURLSessionDataTask *task;

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;
@end
