//
//  ViewController.m
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/14.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "ViewController.h"
#import "Qdt_Filter.h"

@interface ViewController ()<QdtFilterDelegate>
@property (nonatomic, copy) NSArray *category;
@property (nonatomic, strong) Qdt_Filter *filter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.category = [self creatDatas];
    self.filter = [[Qdt_Filter alloc] initFilterWithCategorys:self.category filterFrame:CGRectMake(0, 24, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2)];
    self.filter.delegate = self;
    [self.view addSubview:self.filter.view];
}

- (void)filter:(Qdt_Filter *)filter category:(QdtFilterCategory *)category getSecondarys:(QdtFilterFetchSecondarysBlock)secondarys{
    //请求.....
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *arry2 = [NSMutableArray new];
        for (NSInteger j = 0; j < random()%20 + 1; j++) {
            QdtFilterBaseModel *model = [QdtFilterBaseModel new];
            model.Name = [NSString stringWithFormat:@"%@___%ld",category.mainCategory.Name,j];
            [arry2 addObject:model];
        }
        
        category.secondaryCategorys = [NSArray arrayWithArray:arry2];
        secondarys();
    });
}

- (NSArray *)creatDatas{
    NSMutableArray *arry = [NSMutableArray new];
    for (NSInteger i = 0; i < 10; i++) {
        QdtFilterCategory *category = [QdtFilterCategory new];
        QdtFilterBaseModel *m = [QdtFilterBaseModel new];
        m.Name = [NSString stringWithFormat:@"main___%ld",i];
        category.mainCategory = m;
        if (i%2 == 0) {
            category.allowsMultipleSelection = YES;
            NSMutableArray *arry2 = [NSMutableArray new];
            for (NSInteger j = 0; j < random()%20 + 1; j++) {
                QdtFilterBaseModel *model = [QdtFilterBaseModel new];
                model.Name = [NSString stringWithFormat:@"%ld___%ld",i,j];
                [arry2 addObject:model];
            }
            category.secondaryCategorys = [NSArray arrayWithArray:arry2];
        }
    
        
        [arry addObject:category];
    }
    return [NSArray arrayWithArray:arry];
}

- (IBAction)action:(UIButton *)sender {
    [self.filter showFilterCompletion:^(NSMutableArray<QdtFilterCollectionModel *> *collects) {
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
