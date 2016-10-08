//
//  BlockTrigger.h
//  ExBlock
//
//  Created by Pavel Tsybulin on 10/7/16.
//  Copyright © 2016 Pavel Tsybulin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockTrigger : NSObject

@property (nonatomic, strong) NSString *urlFilter ;
@property (nonatomic, strong) NSArray<NSString *> *loadType ;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary ;
- (NSDictionary *)toDictionary ;

@end
