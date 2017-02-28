//
//  NSCalendar+Distance.m
//  Test
//
//  Created by zoenet on 2017/2/28.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "NSCalendar+Distance.h"

@implementation NSCalendar (Distance)

+(NSDate*)distanceTodayOffsetDays:(NSInteger)days{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    [components setDay:(components.day + days)];
    return [calendar dateFromComponents:components];
}

+(NSDate*)distanceTodayOffsetMonthes:(NSInteger)monthes{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    [components setMonth:(components.month + monthes)];
    return [calendar dateFromComponents:components];
}

@end
