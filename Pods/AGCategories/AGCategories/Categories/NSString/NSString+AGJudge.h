//
//  NSString+AGJudge.h
//  
//
//  Created by JohnnyB0Y on 15/10/3.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//  

#import <Foundation/Foundation.h>

@interface NSString (AGJudge)
/** 字符数量 */
- (NSUInteger) ag_lengthOfCharacter;

/** 字符长度是否在范围内; location => nim, length => max */
- (BOOL) ag_isLengthOfCharacterInRange:(NSRange)range;

#pragma mark Number character

- (BOOL) ag_onlyNumberCharacter;

- (BOOL) ag_containsNumberCharacter;

- (NSUInteger) ag_lengthOfNumberCharacter;


#pragma mark English character

- (BOOL) ag_onlyEnglishCharacter;

- (BOOL) ag_containsEnglishCharacter;

- (NSUInteger) ag_lengthOfEnglishCharacter;


#pragma mark Chinese character

- (BOOL) ag_onlyChineseCharacter;

- (BOOL) ag_containsChineseCharacter;

- (NSUInteger) ag_lengthOfChineseCharacter;

#pragma mark Emoji character

- (BOOL) ag_onlyEmojiCharacter;

- (BOOL) ag_containsEmojiCharacter;

- (NSUInteger) ag_lengthOfEmojiCharacter;


#pragma mark Other
/** 是否 手机号码 */
- (BOOL) ag_isMobileNumber;

/** 是否 电子邮箱 */
- (BOOL) ag_isEmailAddress;

/**  是否 QQ号码 */
- (BOOL) ag_isQQNumber;

@end
