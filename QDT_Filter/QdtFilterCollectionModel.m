//
//  QdtCollectionModel.m
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/15.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "QdtFilterCollectionModel.h"

@implementation QdtFilterCollectionModel
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content selectedModel:(QdtFilterBaseModel *)selectedModel
{
    self = [super init];
    if (self) {
        self.title = title;
        self.content = content;
        self.selectedModel = selectedModel;
    }
    return self;
}
@end
