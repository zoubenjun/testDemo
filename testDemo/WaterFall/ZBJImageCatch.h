//
//  ZBJImageCatch.h
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface ZBJImageCatch : NSObject
+ (instancetype)share;

- (void)imageWithUrlString:(NSString *)urlString completion:(void (^)(UIImage *image))completion;
- (void)clearImageCatch;

@end

NS_ASSUME_NONNULL_END
