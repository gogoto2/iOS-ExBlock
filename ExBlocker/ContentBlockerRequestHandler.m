//
//  ContentBlockerRequestHandler.m
//  ExBlocker
//
//  Created by Pavel Tsybulin on 10/7/16.
//  Copyright © 2016 Pavel Tsybulin. All rights reserved.
//

#import "ContentBlockerRequestHandler.h"

@interface ContentBlockerRequestHandler ()

@end

@implementation ContentBlockerRequestHandler

- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context {
    NSLog(@"BEGIN BEGIN BEGIN") ;
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"blockerList.json"] ;
    
    NSItemProvider *attachment ;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSURL *url = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0] URLByAppendingPathComponent:@"blockerList.json"] ;
        attachment = [[NSItemProvider alloc] initWithContentsOfURL:url] ;
    } else {
        attachment = [[NSItemProvider alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"blockerList" withExtension:@"json"]] ;
    }
    
    NSExtensionItem *item = [[NSExtensionItem alloc] init];
    item.attachments = @[attachment];
    
    [context completeRequestReturningItems:@[item] completionHandler:nil];
}

@end
