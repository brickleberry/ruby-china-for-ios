//
//  RCTopic.m
//  ruby-china
//
//  Created by NSRails autogen on 12/10/2012.
//  Copyright (c) 2012 jason. All rights reserved.
//
#import <RestKit.h>
#import "RCTopic.h"
#import "RCUser.h"
#import "RCNode.h"
#import "RCReply.h"

@implementation RCTopic
@synthesize user, node, lastReplyUserId, lastReplyUserLogin, replies, title, body, bodyHtml, repliesCount, repliedAt, nodeId, nodeName, hits;

- (void) createReply: (RCReply *) reply async: (void (^)(id object, NSError *error)) async {
    [[RKObjectManager sharedManager] postObject:reply
                                           path:[NSString stringWithFormat:@"topics/%@/replies",self.ID]
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                async([mappingResult firstObject], nil);
                                            });
                                        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            //
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                async(nil, error);
                                            });
                                        }];

}

@end
