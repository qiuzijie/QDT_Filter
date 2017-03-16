//
//  QdtFilterCollectionCell.h
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/14.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QdtFilterCollectionModel.h"

@interface QdtFilterCollectionCell : UICollectionViewCell
@property (nonatomic, strong) QdtFilterCollectionModel *collectModel;
@property (nonatomic, assign) BOOL grayStyle;
@end
