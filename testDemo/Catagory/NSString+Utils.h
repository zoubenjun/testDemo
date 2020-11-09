//
//  NSString+Utils.h
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Utils)

- (double)heightWithMaxWidth:(double)maxWidth
                        font:(UIFont *)font
              lineBreakModel:(NSLineBreakMode)mode;

- (NSString *)md5;

@end

NS_ASSUME_NONNULL_END
