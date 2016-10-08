//
//  BlockRule.h
//  ExBlock
//
//  Created by Pavel Tsybulin on 10/7/16.
//  Copyright © 2016 Pavel Tsybulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockAction.h"
#import "BlockTrigger.h"

@interface BlockRule : NSObject

@property (strong, nonatomic) BlockAction *action ;
@property (strong, nonatomic) BlockTrigger *trigger ;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary ;
- (NSDictionary *)toDictionary ;

@end
