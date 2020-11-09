//
//  ZBJCollectionViewFlowLayout.m
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import "ZBJCollectionViewFlowLayout.h"

@interface ZBJCollectionViewFlowLayout()

@property (nonatomic, strong) NSMutableArray *attArrays;
@property (nonatomic, strong) NSMutableArray *colHArrays;
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation ZBJCollectionViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.contentHeight = 0;
        self.colSpacing = 0;
        self.rowSpacing = 0;
        self.colCount = 2;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.colHArrays = [NSMutableArray array];
        self.attArrays = [NSMutableArray array];
    }
    return self;
}

- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.contentHeight = 0;

    [self.colHArrays removeAllObjects];
    for (NSInteger i = 0; i < self.colCount ; i ++) {
        [self.colHArrays addObject:@(0)];
    }
    
    [self.attArrays removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes * atts = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attArrays addObject:atts];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes * atts = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
    CGSize size = [self.delegate flowLayout:self heightForItemAtIndexPath:indexPath];
    CGFloat cellW = size.width;
    CGFloat cellH = size.height;

    NSInteger column = 0;
    CGFloat minColH = [self.colHArrays[0] doubleValue];
    
    for (int i = 1; i < self.colCount; i++) {
        
        CGFloat colH = [self.colHArrays[i] doubleValue];
        
        if (minColH > colH) {
            minColH = colH;
            column = i;
        }
    }
    
    CGFloat cellX = self.sectionInset.left + column * (cellW + self.colSpacing);
    CGFloat cellY = minColH;
    if (cellY != self.sectionInset.top) {
        cellY += self.rowSpacing;
    }
    
    atts.frame = CGRectMake(cellX, cellY, cellW, cellH);
    
    self.colHArrays[column] = @(CGRectGetMaxY(atts.frame));
    
    CGFloat maxColH = [self.colHArrays[column] doubleValue];
    if (self.contentHeight < maxColH) {
        self.contentHeight = maxColH;
    }
    
    return atts;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attArrays;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.contentHeight + self.sectionInset.bottom + self.sectionInset.top);
}

#pragma mark ————— lazy load —————
- (NSMutableArray *)attArrays {
    if (!_attArrays) {
        _attArrays = [NSMutableArray array];
    }
    
    return _attArrays;
}

- (NSMutableArray *)colHArrays {
    if (!_colHArrays) {
        _colHArrays = [NSMutableArray array];
    }
    
    return _colHArrays;
}

@end
