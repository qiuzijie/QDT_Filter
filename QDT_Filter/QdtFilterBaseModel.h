//
//  QdtFilterCommonModel.h
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/14.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QdtFilterBaseModel : NSObject

@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, copy  ) NSString *Name;
@property (nonatomic, assign) NSUInteger Type;
@property (nonatomic, assign) BOOL selected;
@end
