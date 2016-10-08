//
//  BlockTrigger.m
//  ExBlock
//
//  Created by Pavel Tsybulin on 10/7/16.
//  Copyright © 2016 Pavel Tsybulin. All rights reserved.
//

#import "BlockTrigger.h"

@implementation BlockTrigger

- (instancetype)init {
    if (self = [super init]) {
        self.loadType = @[@"third-party", @"first-party"] ;
        self.urlFilter = @"*badsite*" ;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.loadType = dictionary[@"load-type"] ;
        self.urlFilter = dictionary[@"url-filter"] ;
    }
    return self ;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"BlockTrigger: load-type = %@, url-filter = %@", self.loadType, self.urlFilter] ;
}

- (NSDictionary *)toDictionary {
    return @{@"url-filter" : self.urlFilter, @"load-type" : self.loadType, @"url-filter-is-case-sensitive" : @YES} ;
}

@end
