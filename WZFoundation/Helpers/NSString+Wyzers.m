//
//  NSString+Wyzers.m
//  WZFoundation
//
//  Created by Menno on 15-03-12.
//  Copyright (c) 2012 Wyzers. All rights reserved.
//

#import "NSString+Wyzers.h"
#import <CommonCrypto/CommonDigest.h>

MAKE_CATEGORIES_LOADABLE(NSSTRING_WYZERS)
@implementation NSString (Wyzers)
- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}
@end
