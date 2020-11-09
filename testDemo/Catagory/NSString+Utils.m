//
//  NSString+Utils.m
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import "NSString+Utils.h"

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

@end
