//
//  QdtFilterCategory.h
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/14.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtFilterBaseModel.h"
@interface QdtFilterCategory : NSObject

@property (nonatomic, strong) QdtFilterBaseModel *mainCategory;
@property (nonatomic, copy  ) NSArray<QdtFilterBaseModel *> *secondaryCategorys;
@property (nonatomic, assign) BOOL allowsMultipleSelection;

@end
