//
//  NSString+AGJudge.m
//  
//
//  Created by JohnnyB0Y on 15/10/3.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//

#import "NSString+AGJudge.h"
#import <objc/runtime.h>

typedef BOOL(*AGIsXXXCharacterFunc)(const unichar hs, const unichar ls, int strLen);

int ag_unicodeWithCodeUnit(const unichar highSurrogate, const unichar lowSurrogate);
int ag_unicodeWithSubstring(NSString *substring);

BOOL ag_isEnglishUnichar(const unichar hs, const unichar ls, int strLen);
BOOL ag_isNumberUnichar(const unichar hs, const unichar ls, int strLen);
//BOOL ag_isPunctuationUnichar(const unichar hs, const unichar ls, int strLen);
BOOL ag_isChineseUnichar(const unichar hs, const unichar ls, int strLen);
BOOL ag_isEmojiUnichar(const unichar hs, const unichar ls, int strLen);

@implementation NSString (AGJudge)

#pragma mark - ---------- Public Methods ----------
- (NSUInteger) ag_lengthOfCharacter
{
    if ( self.length <= 0 ) return 0;
    
    __block NSUInteger count = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        count++;
    }];
    return count;
}

- (BOOL) ag_isLengthOfCharacterInRange:(NSRange)range
{
    NSUInteger strLen = [self ag_lengthOfCharacter];
    BOOL min = strLen >= range.location;
    BOOL max = strLen <= range.length;
    return min && max;
}

- (BOOL) ag_onlyNumberCharacter
{
    return [self _onlyXXXCharacterWithCFunction:ag_isNumberUnichar];
}
- (BOOL) ag_containsNumberCharacter
{
    return [self _containsXXXCharacterWithCFunction:ag_isNumberUnichar];
}
- (NSUInteger) ag_lengthOfNumberCharacter
{
    return [self _lengthOfXXXCharacterWithCFunction:ag_isNumberUnichar];
}


- (BOOL) ag_onlyEnglishCharacter
{
    return [self _onlyXXXCharacterWithCFunction:ag_isEnglishUnichar];
    
}
- (BOOL) ag_containsEnglishCharacter
{
    return [self _containsXXXCharacterWithCFunction:ag_isEnglishUnichar];
}
- (NSUInteger) ag_lengthOfEnglishCharacter
{
    return [self _lengthOfXXXCharacterWithCFunction:ag_isEnglishUnichar];
}


- (BOOL) ag_onlyChineseCharacter
{
    return [self _onlyXXXCharacterWithCFunction:ag_isChineseUnichar];
}
- (BOOL) ag_containsChineseCharacter
{
    return [self _containsXXXCharacterWithCFunction:ag_isChineseUnichar];
}
- (NSUInteger) ag_lengthOfChineseCharacter
{
    return [self _lengthOfXXXCharacterWithCFunction:ag_isChineseUnichar];
}


- (BOOL) ag_onlyEmojiCharacter
{
    return [self _onlyXXXCharacterWithCFunction:ag_isEmojiUnichar];
}
- (BOOL) ag_containsEmojiCharacter
{
    return [self _containsXXXCharacterWithCFunction:ag_isEmojiUnichar];
}
- (NSUInteger) ag_lengthOfEmojiCharacter
{
    return [self _lengthOfXXXCharacterWithCFunction:ag_isEmojiUnichar];
}


/** 是否 手机号码 */
- (BOOL) ag_isMobileNumber
{
    if ( self.length <= 0 ) return NO;
    
    //手机号以13, 15, 17, 18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$";
    // 适配新号码
    NSString *phoneRegex = @"^1\\d{10}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [predicate evaluateWithObject:self];
}

/** 是否 电子邮箱 */
- (BOOL) ag_isEmailAddress
{
    if ( self.length <= 0 ) return NO;
    
    NSString *expression
    = [NSString stringWithFormat:@"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"];
    
    NSError *error;
    NSRegularExpression *regex
    = [[NSRegularExpression alloc] initWithPattern:expression
                                           options:NSRegularExpressionCaseInsensitive
                                             error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:self
                                                    options:0
                                                      range:NSMakeRange(0,[self length])];
    
    return match != nil;
}

/**  是否 QQ号码 */
- (BOOL) ag_isQQNumber
{
    if ( self.length <= 0 ) return NO;
    
    NSString *qqRegex = @"^[1-9][0-9]{4,}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    return [predicate evaluateWithObject:self];
}


#pragma mark - ---------- Private Methods ----------
- (BOOL) _onlyXXXCharacterWithCFunction:(AGIsXXXCharacterFunc)func
{
    if ( self.length <= 0 ) return NO;
    
    __block BOOL is = YES;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        int strLen = (int)substringRange.length;
        unichar hs = [substring characterAtIndex:0];
        unichar ls = strLen > 1 ? [substring characterAtIndex:1] : 0;
        if ( func(hs, ls, strLen) == NO ) {
            is = NO;
            *stop = YES;
        }
    }];
    return is;
}

- (BOOL) _containsXXXCharacterWithCFunction:(AGIsXXXCharacterFunc)func
{
    if ( self.length <= 0 ) return NO;
    
    __block BOOL contains = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        int strLen = (int)substringRange.length;
        unichar hs = [substring characterAtIndex:0];
        unichar ls = strLen > 1 ? [substring characterAtIndex:1] : 0;
        if ( func(hs, ls, strLen) ) {
            contains = YES;
            *stop = YES;
        }
    }];
    return contains;
}

- (NSInteger) _lengthOfXXXCharacterWithCFunction:(AGIsXXXCharacterFunc)func
{
    if ( self.length <= 0 ) return 0;
    
    __block NSInteger count = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        int strLen = (int)substringRange.length;
        unichar hs = [substring characterAtIndex:0];
        unichar ls = strLen > 1 ? [substring characterAtIndex:1] : 0;
        if ( func(hs, ls, strLen) ) {
            count++;
        }
    }];
    return count;
}

@end

/** U+D800 ~ U+DFFF */
int ag_unicodeWithCodeUnit(const unichar highSurrogate, const unichar lowSurrogate)
{
    // https://zh.wikipedia.org/wiki/UTF-16
    /**
     w1 = 0xd800;
     w2 = 0xdc00;
     highSurrogate = w1 | Vh; ==> Vh = highSurrogate ^ w1;
     lowSurrogate  = w2 | Vl; ==> Vl = lowSurrogate  ^ w2;
     
     V = Vh << 10 + Vl + 0x10000;
     */
    
    // V - 0x10000；-》 分成高低位 Vh、Vl；
    
    return ((highSurrogate ^ 0xd800) << 10) + (lowSurrogate ^ 0xdc00) + 0x10000;
}

int ag_unicodeWithSubstring(NSString *substring)
{
    NSCParameterAssert(substring);
    const unichar hs = [substring characterAtIndex:0];
    
    if ( substring.length <= 1 ) {
        return hs;
    }
    
    const unichar ls = [substring characterAtIndex:1];
    return ag_unicodeWithCodeUnit(hs, ls);
}

BOOL ag_isEnglishUnichar(const unichar hs, const unichar ls, int strLen)
{
    if ( strLen > 1 ) {
        return NO;
    }
    
    // a~z 0x61~0x7a A~Z 0x41~0x5a
    // 未考虑相似的字符
    if ( hs < 0x41 || (hs > 0x5a && hs < 0x61) || hs > 0x7a ) {
        return NO;
    }
    return YES;
}

BOOL ag_isNumberUnichar(const unichar hs, const unichar ls, int strLen)
{
    if ( strLen > 1 ) {
        return NO;
    }
    // 0~9 0x30~0x39
    if ( hs < 0x30 || hs > 0x39 ) {
        return NO;
    }
    return YES;
}

BOOL ag_isChineseUnichar(const unichar hs, const unichar ls, int strLen)
{
    // https://www.qqxiuzi.cn/zh/hanzi-unicode-bianma.php
    // 还有扩展汉字 Unicode
    // unichar 最大 131072；
    // 一~龥  \u4e00~\u9fa5
    if ( hs >= 0x4e00 || hs <= 0x9fa5 ) {
        return YES;
    }
    return NO;
}

BOOL ag_isEmojiUnichar(const unichar hs, const unichar ls, int strLen)
{
    // https://emojipedia.org/emoji/
    // https://github.com/QuickBlox/quickblox-ios-sdk/blob/master/sample-chat/Pods/SearchEmojiOnString/SearchEmojiOnString-iOS/NSString%2BEMOEmoji.m
    BOOL isEomji = NO;
    if (0xd800 <= hs && hs <= 0xdbff) {
        if ( strLen > 1 ) {
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1fbd0) {
                isEomji = YES;
            }
        }
    }
    else if ( strLen > 1 ) {
        if (ls == 0x20e3 || ls == 0xfe0f) {
            isEomji = YES;
        }
    }
    else {
        if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
            isEomji = YES;
        }
        else if (0x2B05 <= hs && hs <= 0x2b07) {
            isEomji = YES;
        }
        else if (0x2934 <= hs && hs <= 0x2935) {
            isEomji = YES;
        }
        else if (0x3297 <= hs && hs <= 0x3299) {
            isEomji = YES;
        }
        else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
            isEomji = YES;
        }
    }
    return isEomji;
}
