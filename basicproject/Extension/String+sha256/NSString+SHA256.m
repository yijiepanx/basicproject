//
//  NSString+SHA256.m
//  forex-ios
//
//  Created by 潘艺杰 on 2019/11/9.
//  Copyright © 2019 潘艺杰. All rights reserved.
//

#import "NSString+SHA256.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SHA256)
- (NSString *)SHA256
{
//    const char *s = [self cStringUsingEncoding:NSASCIIStringEncoding];
//    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
//
//    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
//    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
//    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
//    NSString *hash = [out description];
//    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
//    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
//    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
//    return hash;
    
    const char* str = [self cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (CC_LONG)strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_SHA256_DIGEST_LENGTH; i++)
    {
        [ret appendFormat:@"%02x",result[i]];
    }
    ret = (NSMutableString *)[ret lowercaseString];
    return ret;

}
@end
