//
//  QdtCollectionModel.h
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/15.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtFilterCollectionModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)content;
@end
