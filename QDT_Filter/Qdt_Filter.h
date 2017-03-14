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

@interface Qdt_Filter : UIViewController
@property (nonatomic, copy) NSArray<QdtFilterCategory *> *categorys;
@end
