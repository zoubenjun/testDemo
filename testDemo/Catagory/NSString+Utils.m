//
//  NSString+Utils.m
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Utils)

- (double)heightWithMaxWidth:(double)maxWidth
                        font:(UIFont *)font
              lineBreakModel:(NSLineBreakMode)mode {
    CGSize textBlockMinSize = {maxWidth, CGFLOAT_MAX};
    CGSize size =
    [self boundingRectWithSize:textBlockMinSize
                       options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{NSFontAttributeName:font}
                       context:nil].size;
    return size.height;
}

- (NSString *)md5 {
    const char* character = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(character, strlen(character), result);
    NSMutableString *md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5String appendFormat:@"%02x",result[i]];
    }
    
    return md5String;
}

@end
