//
//  AGBaseVerifier.m
//  AGVerifyManager
//
//  Created by JohnnyB0Y on 2019/8/7.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGBaseVerifier.h"

@implementation AGBaseVerifier {
    AGVerifyError *_error;
}

+ (AGBaseVerifier *)defaultInstance
{
    return [[self alloc] init];
}

- (AGVerifyError *)ag_verifyData:(id)data
{
    AGVerifyError *error = _error;
    _error = nil;
    return error;
}

- (AGVerifyError *)error
{
    if ( nil == _error ) {
        _error = [[AGVerifyError alloc] init];
    }
    return _error;
}

@end
