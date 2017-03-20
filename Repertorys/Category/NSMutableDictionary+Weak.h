//
//  NSMutableDictionary+Weak.h
//  Test----实现弱引用存储
//
//  Created by zoenet on 2017/3/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Weak)

- (void)weak_setObject:(id)anObject forKey:(NSString *)aKey;

@end
