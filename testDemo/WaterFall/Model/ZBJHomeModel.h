//
//  ZBJHomeModel.h
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import <ZhuoZhuo/ZhuoZhuo.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBJHomeModel : NSObject

@property(nonatomic, strong) RDMTCellData *data;

@property(nonatomic, assign) double mainImageH;
@property(nonatomic, assign) double mainTitleH;
@property(nonatomic, assign) double subTitleH;
@property(nonatomic, assign) double cellW;
@property(nonatomic, assign) double cellH;

@end

NS_ASSUME_NONNULL_END
