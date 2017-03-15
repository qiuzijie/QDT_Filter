//
//  QdtFilterCollectionCell.m
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/14.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "QdtFilterCollectionCell.h"

@interface QdtFilterCollectionCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation QdtFilterCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initControls];
    }
    return self;
}

- (void)initControls{
    self.titleLabel = [UILabel new];
    [self addSubview:self.titleLabel];
    
    self.contentLabel = [UILabel new];
    [self addSubview:self.contentLabel];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = [UIColor colorWithRed:12 / 255.0 green:172 / 255.0 blue:199 / 255.0 alpha:1.0];
    
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textColor = [UIColor grayColor];
    
    self.backgroundColor = [UIColor colorWithRed:206/255.0
                                         green:242/255.0
                                          blue:238/255.0
                                         alpha:1];
    
    self.layer.cornerRadius = 5.0;

}

- (void)layoutSubviews{
    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30);
    self.contentLabel.frame = CGRectMake(0, 30, CGRectGetWidth(self.bounds), 20);
}

- (void)setCollectModel:(QdtFilterCollectionModel *)collectModel{
    _collectModel = collectModel;
    self.titleLabel.text = collectModel.title;
    self.contentLabel.text = collectModel.content;
}

@end
