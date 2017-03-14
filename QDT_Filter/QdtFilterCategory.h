//
//  QdtFilterCategory.h
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/14.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QdtFilterCommonModel.h"
@interface QdtFilterCategory : NSObject

@property (nonatomic, strong) QdtFilterCommonModel *mainCategory;
@property (nonatomic, copy  ) NSArray<QdtFilterCommonModel *> *secondaryCategorys;

@end
