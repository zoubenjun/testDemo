//
//  ZBJCollectionViewFlowLayout.h
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBJCollectionViewFlowLayout;

@protocol  ZBJCollectionViewFlowLayoutDeleaget<NSObject>

@required
- (CGSize)flowLayout:(ZBJCollectionViewFlowLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface ZBJCollectionViewFlowLayout : UICollectionViewLayout
@property(nonatomic, assign) UIEdgeInsets sectionInset;
@property(nonatomic, assign) int colCount;
@property(nonatomic, assign) double colSpacing;
@property(nonatomic, assign) double rowSpacing;

@property (nonatomic, weak) id<ZBJCollectionViewFlowLayoutDeleaget> delegate;

@end

NS_ASSUME_NONNULL_END
