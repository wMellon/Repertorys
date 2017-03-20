//
//  NSMutableDictionary+Weak.m
//  Test
//
//  Created by zoenet on 2017/3/20.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "NSMutableDictionary+Weak.h"

@implementation NSMutableDictionary (Weak)

typedef id (^WeakReference)(void);

WeakReference makeWeakReference(id object) {
    __weak id weakref = object;
    return ^{
        return weakref;
    };
}

id weakReferenceNonretainedObjectValue(WeakReference ref) {
    return ref ? ref() : nil;
}
- (void)weak_setObject:(id)anObject forKey:(NSString *)aKey {
    [self setObject:makeWeakReference(anObject) forKey:aKey];
}

- (void)weak_setObjectWithDictionary:(NSDictionary *)dic {
    for (NSString *key in dic.allKeys) {
        [self setObject:makeWeakReference(dic[key]) forKey:key];
    }
}

- (id)weak_getObjectForKey:(NSString *)key {
    return weakReferenceNonretainedObjectValue(self[key]);
}

@end
