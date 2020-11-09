//
//  ViewController.m
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import "ViewController.h"
#import "ZBJCollectionViewFlowLayout.h"
#import "ZBJHomeModel.h"
#import "ZBJHomeCollectionViewCell.h"
#import "NSString+Utils.h"


#define kScrenH ([[UIScreen mainScreen] bounds].size.height)
#define kScrenW ([[UIScreen mainScreen] bounds].size.width)
#define KSpace 8
#define kCollectionCellW ((kScrenW - 3 * KSpace) / 2)

@interface ViewController ()<UICollectionViewDataSource, ZBJCollectionViewFlowLayoutDeleaget>

@property (nonatomic, strong) NSMutableArray<ZBJHomeModel*>* dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self zbj_loadData];
    [self zbj_loadView];
}

- (void)zbj_loadData {
    _dataArray = [NSMutableArray array];
    
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        NSArray<RDMTCellData*>* temp = GetListData__NotAllowInMainThread();
        for (RDMTCellData *data in temp) {
            ZBJHomeModel *model = [[ZBJHomeModel alloc] init];
            if (data.DataType == 1 || data.DataType == 3) {
                model.mainImageH = data.Image.ImageHeight*(kCollectionCellW/data.Image.ImageWidth);
            }
            if (data.DataType == 2 || data.DataType == 3) {
                model.mainTitleH = [data.TitleText heightWithMaxWidth:kCollectionCellW font:[UIFont systemFontOfSize:14] lineBreakModel:NSLineBreakByWordWrapping];
                model.subTitleH = [data.SecondTitleText heightWithMaxWidth:kCollectionCellW font:[UIFont systemFontOfSize:14] lineBreakModel:NSLineBreakByWordWrapping];
            }
            model.cellW = kCollectionCellW;
            model.cellH = model.mainImageH + model.mainTitleH + model.subTitleH + 80;
            model.data = data;
            [strongSelf.dataArray addObject:model];
        }
        __weak typeof (self) weakSelf = self;

//        NSLog(@"%@",strongSelf.dataArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof (weakSelf) strongSelf = weakSelf;
            [strongSelf.collectionView reloadData];
        });
    });
}

- (void)zbj_loadView {
    [self.view addSubview:self.collectionView];
}

#pragma mark- UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    [collectionView.collectionViewLayout invalidateLayout];
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBJHomeCollectionViewCell *itemCell = (ZBJHomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZBJHomeCollectionViewCell class]) forIndexPath:indexPath];
    ZBJHomeModel *model = [self.dataArray objectAtIndex:indexPath.row];
    itemCell.model = model;
    
    return itemCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataArray.count > indexPath.row) {
        
    }
}

#pragma mark ————— ZBJCollectionViewFlowLayoutDeleaget —————
- (CGSize)flowLayout:(ZBJCollectionViewFlowLayout *)flowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZBJHomeModel *model = [self.dataArray objectAtIndex:indexPath.row];
    return CGSizeMake(model.cellW, model.cellH);
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        CGFloat space = KSpace;
        ZBJCollectionViewFlowLayout * layout = [[ZBJCollectionViewFlowLayout alloc] init];
        layout.delegate = self;
        
        layout.sectionInset = UIEdgeInsetsMake(0, KSpace, 0, KSpace);
        layout.colSpacing = space;
        layout.rowSpacing = space;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.view.safeAreaInsets.top, kScrenW, kScrenH-self.view.safeAreaInsets.top-self.view.safeAreaInsets.bottom) collectionViewLayout:layout];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsVerticalScrollIndicator:NO];
        [_collectionView registerClass:[ZBJHomeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ZBJHomeCollectionViewCell class])];
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor orangeColor];
    }
    return _collectionView;
}

@end
