//
//  NSCalendar+Distance.m
//  Test
//
//  Created by zoenet on 2017/2/28.
//  Copyright © 2017年 xxb. All rights reserved.
//

#import "NSDate+Distance.h"

@implementation NSDate (Distance)

+(NSDate*)distanceTodayOffsetDays:(NSInteger)days{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
    [components setDay:(components.day + days)];
    return [calendar dateFromComponents:components];
}

+(NSDate*)distanceTodayOffsetMonthes:(NSInteger)monthes{
    NSDate *now = [NSDate date];
    return [now distanceByOffsetMonthes:monthes];
}

-(NSDate*)distanceByOffsetMonthes:(NSInteger)monthes{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:self];
    [components setMonth:(components.month + monthes)];
    return [calendar dateFromComponents:components];
}

-(NSDate*)getFirstDateForThisMonth{
    NSDate *startDateOfDay;
    NSTimeInterval TIOfDay;
    //获取该日期最早的天数
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDateOfDay interval:&TIOfDay forDate:self];
    return startDateOfDay;
}
@end
