//
//  BlockAction.h
//  ExBlock
//
//  Created by Pavel Tsybulin on 10/7/16.
//  Copyright © 2016 Pavel Tsybulin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockAction : NSObject

@property (strong, nonatomic) NSString *type ;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary ;
- (NSDictionary *)toDictionary ;

@end
