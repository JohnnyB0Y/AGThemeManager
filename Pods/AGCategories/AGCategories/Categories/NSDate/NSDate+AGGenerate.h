//
//  NSDate+AGGenerate.h
//
//
//  Created by JohnnyB0Y on 15/10/3.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kNSDateFormatModeDateAndTime @"yyyy-MM-dd HH:mm:ss"
#define kNSDateFormatModeOnlyDate @"yyyy-MM-dd"
#define kNSDateFormatModeOnlyTime @"HH:mm:ss"


typedef NS_ENUM(NSUInteger, AGDateFormatMode) {
    AGDateFormatModeOnlyDate,
    AGDateFormatModeOnlyTime,
    AGDateFormatModeDateAndTime,
};

@interface NSDate (AGGenerate)

#pragma mark 日期比较
- (NSDateComponents *) ag_componentsToDate:(NSDate *)date calendarIdentifier:(NSCalendarIdentifier)identifier;
- (NSDateComponents *) ag_componentsToDate:(NSDate *)date calendar:(nullable NSCalendar *)calendar;
- (NSDateComponents *) ag_componentsToDate:(NSDate *)date;

- (BOOL) ag_isToday;
- (BOOL) ag_isTomorrow;
- (BOOL) ag_isYesterday;
- (BOOL) ag_isBeforeToday;
- (BOOL) ag_isThisYear;

#pragma mark 根据 NSCalendarUnit 枚举，获取（年、月、日、时、分、秒）数值字符串 NSString
+ (NSString *) ag_stringWithDateUnit:(NSCalendarUnit)unitFlags calendarIdentifier:(NSCalendarIdentifier)identifier;
+ (NSString *) ag_stringWithDateUnit:(NSCalendarUnit)unitFlags calendar:(nullable NSCalendar *)calendar;
+ (NSString *) ag_stringWithDateUnit:(NSCalendarUnit)unitFlags;

- (NSString *) ag_stringWithUnit:(NSCalendarUnit)unitFlags calendarIdentifier:(NSCalendarIdentifier)identifier;
- (NSString *) ag_stringWithUnit:(NSCalendarUnit)unitFlags calendar:(nullable NSCalendar *)calendar;
- (NSString *) ag_stringWithUnit:(NSCalendarUnit)unitFlags;

#pragma mark 根据 NSCalendarUnit 枚举，获取（年、月、日、时、分、秒）数值 NSInteger
+ (NSInteger) ag_integerWithDateUnit:(NSCalendarUnit)unitFlags calendarIdentifier:(NSCalendarIdentifier)identifier;
+ (NSInteger) ag_integerWithDateUnit:(NSCalendarUnit)unitFlags calendar:(nullable NSCalendar *)calendar;
+ (NSInteger) ag_integerWithDateUnit:(NSCalendarUnit)unitFlags;

- (NSInteger) ag_integerWithUnit:(NSCalendarUnit)unitFlags calendarIdentifier:(NSCalendarIdentifier)identifier;
- (NSInteger) ag_integerWithUnit:(NSCalendarUnit)unitFlags calendar:(nullable NSCalendar *)calendar;
- (NSInteger) ag_integerWithUnit:(NSCalendarUnit)unitFlags;

// -----------------------
#pragma mark - NSString、NSNumber、NSTimeInterval ==> NSDate

/**
 毫秒对象转化成NSDate对象

 @param ms 毫秒对象（NSString、NSNumber）
 @return NSDate对象
 */
+ (NSDate *) ag_dateWithMillisecond:(id)ms;

/**
 秒转化成NSDate对象
 
 @param ti 秒（NSTimeInterval）
 @return NSDate对象
 */
+ (NSDate *) ag_dateWithSecondTi:(NSTimeInterval)ti;

/**
 秒对象转化成NSDate对象
 
 @param s 秒对象（NSString、NSNumber）
 @return NSDate对象
 */
+ (NSDate *) ag_dateWithSecond:(id)s;

// ............
#pragma mark - NSString ==> NSDate

/**
 时间格式字符串转化成NSDate对象

 @param fStr 时间格式化字符串（2015-10-10 00:00:00）
 @param mode 格式化模式枚举（与format对应）
 @param name 时区的名字（@"America/Los_Angeles": 美国洛杉矶; @"Pacific/Auckland": 新西兰奥克兰;）
 @return NSDate对象
 */
+ (NSDate *) ag_dateWithFormatString:(NSString *)fStr mode:(AGDateFormatMode)mode timeZoneName:(NSString *)name;
+ (NSDate *) ag_dateWithFormatString:(NSString *)fStr mode:(AGDateFormatMode)mode timeZone:(nullable NSTimeZone *)timeZone;
+ (NSDate *) ag_dateWithFormatString:(NSString *)fStr mode:(AGDateFormatMode)mode;

/**
 时间格式字符串转化成NSDate对象
 
 @param fStr 时间格式化字符串（2015-10-10 00:00:00）
 @param mode 格式化模式字符串（与format对应，@"yyyy-MM-dd HH:mm:ss"）
 @param name 时区的名字（@"America/Los_Angeles": 美国洛杉矶; @"Pacific/Auckland": 新西兰奥克兰;）
 @return NSDate对象
 */
+ (NSDate *) ag_dateWithFormatString:(NSString *)fStr modeString:(NSString *)mode timeZoneName:(NSString *)name;
+ (NSDate *) ag_dateWithFormatString:(NSString *)fStr modeString:(NSString *)mode timeZone:(nullable NSTimeZone *)timeZone;
+ (NSDate *) ag_dateWithFormatString:(NSString *)fStr modeString:(NSString *)mode;


#pragma mark - NSDate ==> NSString

/**
 NSDate对象转化成时间格式字符串

 @param mode 格式化模式枚举
 @param name 时区的名字（@"America/Los_Angeles": 美国洛杉矶; @"Pacific/Auckland": 新西兰奥克兰;）
 @return 时间格式字符串
 */
- (NSString *) ag_stringWithMode:(AGDateFormatMode)mode timeZoneName:(NSString *)name;
- (NSString *) ag_stringWithMode:(AGDateFormatMode)mode timeZone:(nullable NSTimeZone *)timeZone;
- (NSString *) ag_stringWithMode:(AGDateFormatMode)mode;

/**
 NSDate对象转化成时间格式字符串
 
 @param mode 格式化模式字符串（@"yyyy-MM-dd HH:mm:ss"）
 @param name 时区的名字（@"America/Los_Angeles": 美国洛杉矶; @"Pacific/Auckland": 新西兰奥克兰;）
 @return 时间格式字符串
 */
- (NSString *) ag_stringWithModeString:(NSString *)mode timeZoneName:(NSString *)name;
- (NSString *) ag_stringWithModeString:(NSString *)mode timeZone:(nullable NSTimeZone *)timeZone;
- (NSString *) ag_stringWithModeString:(NSString *)mode;

#pragma mark - NSString、NSNumber、NSTimeInterval ==>（ NSDate ）==> NSString

/**
 毫秒对象转化成时间格式字符串

 @param ms 毫秒对象（NSString、NSNumber）
 @param mode 格式化模式枚举
 @param name 时区的名字（@"America/Los_Angeles": 美国洛杉矶; @"Pacific/Auckland": 新西兰奥克兰;）
 @return 时间格式字符串
 */
+ (NSString *) ag_stringWithMillisecond:(id)ms mode:(AGDateFormatMode)mode timeZoneName:(NSString *)name;
+ (NSString *) ag_stringWithMillisecond:(id)ms mode:(AGDateFormatMode)mode timeZone:(nullable NSTimeZone *)timeZone;
+ (NSString *) ag_stringWithMillisecond:(id)ms mode:(AGDateFormatMode)mode;

/**
 毫秒对象转化成时间格式字符串
 
 @param ms 毫秒对象（NSString、NSNumber）
 @param mode 格式化模式字符串（@"yyyy-MM-dd HH:mm:ss"）
 @param name 时区的名字（@"America/Los_Angeles": 美国洛杉矶; @"Pacific/Auckland": 新西兰奥克兰;）
 @return 时间格式字符串
 */
+ (NSString *) ag_stringWithMillisecond:(id)ms modeString:(NSString *)mode timeZoneName:(NSString *)name;
+ (NSString *) ag_stringWithMillisecond:(id)ms modeString:(NSString *)mode timeZone:(nullable NSTimeZone *)timeZone;
+ (NSString *) ag_stringWithMillisecond:(id)ms modeString:(NSString *)mode;

// ............ 秒转化成时间格式字符串
+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti mode:(AGDateFormatMode)mode timeZoneName:(NSString *)name;
+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti mode:(AGDateFormatMode)mode timeZone:(nullable NSTimeZone *)timeZone;
+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti mode:(AGDateFormatMode)mode;

+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti modeString:(NSString *)mode timeZoneName:(NSString *)name;
+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti modeString:(NSString *)mode timeZone:(nullable NSTimeZone *)timeZone;
+ (NSString *) ag_stringWithSecondTi:(NSTimeInterval)ti modeString:(NSString *)mode;

// ............ 秒对象转化成时间格式字符串
+ (NSString *) ag_stringWithSecond:(id)s mode:(AGDateFormatMode)mode timeZoneName:(NSString *)name;
+ (NSString *) ag_stringWithSecond:(id)s mode:(AGDateFormatMode)mode timeZone:(nullable NSTimeZone *)timeZone;
+ (NSString *) ag_stringWithSecond:(id)s mode:(AGDateFormatMode)mode;

+ (NSString *) ag_stringWithSecond:(id)s modeString:(NSString *)mode timeZoneName:(NSString *)name;
+ (NSString *) ag_stringWithSecond:(id)s modeString:(NSString *)mode timeZone:(nullable NSTimeZone *)timeZone;
+ (NSString *) ag_stringWithSecond:(id)s modeString:(NSString *)mode;

@end

NS_ASSUME_NONNULL_END
