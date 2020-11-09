//
//  ZBJHomeCollectionViewCell.m
//  testDemo
//
//  Created by zbj on 2020/11/9.
//  Copyright © 2020 ace. All rights reserved.
//

#import "ZBJHomeCollectionViewCell.h"
#import "ZBJImageCatch.h"

@interface ZBJHomeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *mainTitleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIButton *deleteButton;


@end


@implementation ZBJHomeCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        
        [self.contentView addSubview:self.mainImageView];
        [self.contentView addSubview:self.mainTitleLabel];
        [self.contentView addSubview:self.subTitleLabel];
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

- (void)setModel:(ZBJHomeModel *)model {
    if (model.data.DataType == 1 || model.data.DataType == 3) {
        self.mainImageView.hidden = NO;
        self.mainImageView.frame = CGRectMake(0, 0, model.cellW, model.mainImageH);
        __weak typeof (self) weakSelf = self;
        [[ZBJImageCatch share] imageWithUrlString:model.data.Image.ImageUrl completion:^(UIImage * _Nonnull image) {
            __strong typeof (weakSelf) strongSelf = weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.mainImageView.image = image;
            });
        }];        
    }
    else {
        self.mainImageView.hidden = YES;
    }
    if (model.data.DataType == 2 || model.data.DataType == 3) {
        self.mainTitleLabel.hidden = NO;
        self.subTitleLabel.hidden = NO;
        self.mainTitleLabel.frame = CGRectMake(0, model.mainImageH, model.cellW, model.mainTitleH);
        self.subTitleLabel.frame = CGRectMake(0, model.mainImageH+model.mainTitleH, model.cellW, model.subTitleH);
        self.mainTitleLabel.text = model.data.TitleText;
        self.subTitleLabel.text = model.data.SecondTitleText;

    }
    else {
        self.mainTitleLabel.hidden = YES;
        self.subTitleLabel.hidden = YES;
    }
    self.headImageView.frame = CGRectMake(16, model.mainImageH+model.mainTitleH+model.subTitleH+10, 60, 60);
    self.headImageView.image = [UIImage imageWithData:[[NSData alloc]initWithBase64EncodedString:model.data.HeadImgBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters]];
}

- (UIImageView *)mainImageView {
    if (!_mainImageView) {
        _mainImageView = [UIImageView new];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
        _mainImageView.layer.masksToBounds = YES;
    }
    return _mainImageView;
}
- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}
- (UILabel *)mainTitleLabel {
    if (!_mainTitleLabel) {
        _mainTitleLabel = [UILabel new];
        _mainTitleLabel.font = [UIFont systemFontOfSize:14];
        _mainTitleLabel.textColor = [UIColor redColor];
        _mainTitleLabel.numberOfLines = 0;
    }
    return _mainTitleLabel;
}
- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
        _subTitleLabel.textColor = [UIColor blueColor];
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [[UIButton alloc] init];
        
    }
    return _deleteButton;
}
@end
