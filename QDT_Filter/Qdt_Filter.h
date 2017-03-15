//
//  Qdt_Filter.h
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/14.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QdtFilterCategory.h"
#import "QdtFilterCollectionCell.h"
#import "QdtFilterCollectionModel.h"

@interface Qdt_Filter : UIViewController
@property (nonatomic, copy) NSArray<QdtFilterCategory *> *categorys;
@property (nonatomic, strong) NSMutableArray<QdtFilterCollectionModel *> *collects;
@end
