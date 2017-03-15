//
//  QdtCollectionModel.h
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/15.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtFilterBaseModel.h"

@interface QdtFilterCollectionModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) QdtFilterBaseModel *selectedModel;
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content selectedModel:(QdtFilterBaseModel *)selectedModel;
@end
