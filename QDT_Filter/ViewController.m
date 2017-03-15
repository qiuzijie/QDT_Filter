//
//  ViewController.m
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/14.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "ViewController.h"
#import "Qdt_Filter.h"
#import "Masonry.h"

@interface ViewController ()
@property (nonatomic, copy) NSArray *category;
@property (nonatomic, strong) Qdt_Filter *filter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.category = [self creatDatas];
    self.filter = [Qdt_Filter new];
    self.filter.view.frame = CGRectMake(0, 24, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2);
    [self.view addSubview:self.filter.view];
    self.filter.categorys = self.category;
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
        }
    
        NSMutableArray *arry2 = [NSMutableArray new];
        for (NSInteger j = 0; j < random()%20 + 1; j++) {
            QdtFilterBaseModel *model = [QdtFilterBaseModel new];
            model.Name = [NSString stringWithFormat:@"%ld___%ld",i,j];
            [arry2 addObject:model];
        }
        
        category.secondaryCategorys = [NSArray arrayWithArray:arry2];
        [arry addObject:category];
    }
    return [NSArray arrayWithArray:arry];
}

- (IBAction)action:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
