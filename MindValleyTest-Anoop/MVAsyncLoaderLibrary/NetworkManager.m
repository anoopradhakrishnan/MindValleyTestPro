//
//  NetworkManager.m
//  MindValleyTest-Anoop
//
//  Created by Anoop Radhakrishnan on 09/04/16.
//  Copyright © 2016 Anoop Radhakrishnan. All rights reserved.
//

#import "NetworkManager.h"

#define DataTask_KVOBlock(KEYPATH, BLOCK)\
[self willChangeValueForKey:KEYPATH];\
BLOCK();\
[self didChangeValueForKey:KEYPATH];\

@implementation NetworkManager{
    
    BOOL _finished;
    BOOL _executing;
}

- (instancetype)initWithSession:(NSURLSession *)session URL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        _task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            [weakSelf completeOperationWithBlock:completionHandler data:data response:response error:error];
        }];
        [_task resume];
    }
    return self;
}

- (void)cancel {
    [super cancel];
    [self.task cancel];
}

- (void)start {
    
    if (self.isCancelled) {
        DataTask_KVOBlock(@"isFinished", ^{ _finished = YES; });
        return;
    }
    
    DataTask_KVOBlock(@"isExecuting", ^{
        [self.task resume];
        _executing = YES;
    });
}

- (BOOL)isExecuting {
    return _executing;
}

- (BOOL)isFinished {
    return _finished;
}

- (BOOL)isConcurrent {
    return YES;
}

- (void)completeOperationWithBlock:(void (^)(NSData *, NSURLResponse *, NSError *))block data:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error {
    if (!self.isCancelled && block)
        block(data, response, error);
    [self completeOperation];
}

- (void)completeOperation {
   
    DataTask_KVOBlock(@"isFinished", ^{
        DataTask_KVOBlock(@"isExecuting", ^{
            _executing = NO;
            _finished = YES;
        });
    });
}
@end