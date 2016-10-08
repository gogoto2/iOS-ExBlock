//
//  BlockAction.m
//  ExBlock
//
//  Created by Pavel Tsybulin on 10/7/16.
//  Copyright © 2016 Pavel Tsybulin. All rights reserved.
//

#import "BlockAction.h"

@implementation BlockAction

- (instancetype)init {
    if (self = [super init]) {
        self.type = @"block" ;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.type = dictionary[@"type"] ;
    }
    return self ;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"BlockAction type is %@", self.type] ;
}

- (NSDictionary *)toDictionary {
    return @{@"type" : self.type} ;
}

@end
