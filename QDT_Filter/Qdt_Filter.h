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

typedef void (^QdtFilterCompletionBlock)(NSMutableArray<QdtFilterCollectionModel *> *collects);
typedef void(^QdtFilterFetchSecondarysBlock)(void);

@class Qdt_Filter;
@protocol QdtFilterDelegate <NSObject>

- (void)filter:(Qdt_Filter *)filter category:(QdtFilterCategory *)category getSecondarys:(QdtFilterFetchSecondarysBlock)secondarys;

@end

@interface Qdt_Filter : UIViewController
@property (nonatomic, copy) NSArray<QdtFilterCategory *> *categorys;
@property (nonatomic, strong) NSMutableArray<QdtFilterCollectionModel *> *collects;
@property (nonatomic, assign) CGRect filterFrame;
@property (nonatomic, strong) QdtFilterCompletionBlock completionBlcok;
@property (nonatomic, weak) id<QdtFilterDelegate> delegate;

- (void)showFilterCompletion:(QdtFilterCompletionBlock)completion;
- (instancetype)initFilterWithCategorys:(NSArray<QdtFilterCategory *> *)categorys filterFrame:(CGRect)frame;
@end
