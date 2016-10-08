//
//  BlockRule.m
//  ExBlock
//
//  Created by Pavel Tsybulin on 10/7/16.
//  Copyright © 2016 Pavel Tsybulin. All rights reserved.
//

#import "BlockRule.h"

@implementation BlockRule

- (instancetype)init {
    if (self = [super init]) {
        self.action = [[BlockAction alloc] init] ;
        self.trigger = [[BlockTrigger alloc] init] ;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.action = [[BlockAction alloc] initWithDictionary:dictionary[@"action"]] ;
        self.trigger = [[BlockTrigger alloc] initWithDictionary:dictionary[@"trigger"]] ;
    }
    return self ;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"BlockRule action: %@, trigger: %@", self.action, self.trigger] ;
}

- (NSDictionary *)toDictionary {
    return @{@"action" : [self.action toDictionary], @"trigger" : [self.trigger toDictionary]} ;
}

@end
