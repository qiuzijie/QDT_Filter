//
//  Qdt_Filter.m
//  QDT_Filter
//
//  Created by qiuzijie on 2017/3/14.
//  Copyright © 2017年 qiuzijie. All rights reserved.
//

#import "Qdt_Filter.h"

#define FilterLeftTableCellIdentifier @"leftTCell"
#define FilterRightTableCellIdentifier @"rightTCell"
#define FilterCollectionCellIdentifier @"collectionCell"
#define FilterLeftTableSelectingModel self.categorys[self.leftSelectingIndexPath.row]
#define FilterRightTableSelectingModel FilterLeftTableSelectingModel.secondaryCategorys[indexPath.row]

@interface Qdt_Filter ()<UITableViewDelegate,
                         UITableViewDataSource,
                         UICollectionViewDelegate,
                         UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterHeightConstraint;
@property (strong, nonatomic) IBOutlet UIView *filterView;
@property (nonatomic, assign) BOOL fliterHasHidden;

@property (nonatomic, strong) QdtFilterBaseModel *selectedSingleModel;
@property (nonatomic, strong) NSIndexPath *leftSelectingIndexPath;
@end

@implementation Qdt_Filter

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collects = [NSMutableArray array];
    
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FilterLeftTableCellIdentifier];
    [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FilterRightTableCellIdentifier];
    self.leftTableView.tableFooterView = [UIView new];
    self.rightTableView.tableFooterView = [UIView new];
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(80, 50);
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerClass:[QdtFilterCollectionCell class] forCellWithReuseIdentifier:FilterCollectionCellIdentifier];
}

- (instancetype)initFilterWithCategorys:(NSArray<QdtFilterCategory *> *)categorys filterFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.categorys = categorys;
        self.filterFrame = frame;
        [self initViews];
    }
    return self;
}

- (void)initViews{
    [self.leftTableView reloadData];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    self.leftSelectingIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.rightTableView reloadData];
    self.filterHeightConstraint.constant = self.filterFrame.size.height;
    self.view.frame = CGRectZero;
}

//- (void)setCategorys:(NSArray<QdtFilterCategory *> *)categorys{
//    _categorys = categorys;
//    [self.leftTableView reloadData];
//    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
//    self.leftSelectingIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.rightTableView reloadData];
//}

#pragma mark- tableview Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.rightTableView) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.categorys.count;
    } else{
        if (section == 0) {
            return 1;
        }else{
            return FilterLeftTableSelectingModel.secondaryCategorys.count;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        
        UITableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:FilterLeftTableCellIdentifier forIndexPath:indexPath];
        UIView *leftSelectView = [UIView new];
        leftSelectView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
        leftCell.selectedBackgroundView = leftSelectView;
        leftCell.textLabel.text = self.categorys[indexPath.row].mainCategory.Name;
        
        leftCell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"customerfilter_dot.png"]];
        
        ((UIImageView *)leftCell.accessoryView).hidden = !self.categorys[indexPath.row].mainCategory.selected;
        return leftCell;
        
    } else{
        
        UITableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:FilterRightTableCellIdentifier forIndexPath:indexPath];
        rightCell.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1];
        if (self.categorys[self.leftSelectingIndexPath.row].allowsMultipleSelection == YES) {
            rightCell.accessoryView = [[UIImageView alloc] initWithImage:
                                       [UIImage imageNamed:@"customerfilter_muti_unchecked.png"]
                                                        highlightedImage:
                                       [UIImage imageNamed:@"customerfilter_multi_checked.png"]];
        } else{
            rightCell.accessoryView = [[UIImageView alloc] initWithImage:
                                       nil highlightedImage:
                                       [UIImage imageNamed:@"customerfilter_single_checked.png"]];
        }
        
        if (indexPath.section == 0) {
            rightCell.textLabel.text = @"不限";
            bool b = !self.categorys[self.leftSelectingIndexPath.row].mainCategory.selected;
            ((UIImageView *)rightCell.accessoryView).highlighted = b;
            return rightCell;
        } else{
            rightCell.textLabel.text = FilterRightTableSelectingModel.Name;
            ((UIImageView *)rightCell.accessoryView).highlighted = FilterRightTableSelectingModel.selected;
            return rightCell;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        self.leftSelectingIndexPath = indexPath;
        //刷新右边列表
        [self.rightTableView reloadData];
        
    } else{
        if (indexPath.section == 0) {// 不限
            FilterLeftTableSelectingModel.mainCategory.selected = NO;
            [self reloadLeftTableView];
            
            NSMutableArray *newArr = [NSMutableArray arrayWithArray:self.collects];
            for (QdtFilterCollectionModel *c in self.collects) {
                if ([c.title isEqualToString:FilterLeftTableSelectingModel.mainCategory.Name]) {
                    [newArr removeObject:c];
                };
            }
            self.collects = newArr;
            [self reloadCollectionView];
            
            for (QdtFilterBaseModel *m in FilterLeftTableSelectingModel.secondaryCategorys) {
                m.selected = NO;
            }
            [self.rightTableView reloadData];
            
        } else{
            //刷新打钩状态和collection
            
            NSString *title = FilterLeftTableSelectingModel.mainCategory.Name;
            NSString *content = FilterRightTableSelectingModel.Name;
            QdtFilterCollectionModel *collect = [[QdtFilterCollectionModel alloc] initWithTitle:title content:content selectedModel:FilterRightTableSelectingModel];
            
            if (FilterLeftTableSelectingModel.allowsMultipleSelection == YES) {//多选
                
                FilterRightTableSelectingModel.selected = !FilterRightTableSelectingModel.selected;
                [self.rightTableView reloadData];
                FilterLeftTableSelectingModel.mainCategory.selected = [self checkRightTableSelectState:FilterLeftTableSelectingModel.secondaryCategorys];
                [self reloadLeftTableView];
                
                for (QdtFilterCollectionModel *cModel in self.collects) {
                    if ([cModel.title isEqualToString:title] && [cModel.content isEqualToString:content]) {
                        [self.collects removeObject:cModel];
                        [self reloadCollectionView];
                        return;
                    }
                }
                [self.collects addObject:collect];
                [self reloadCollectionView];
                
            } else{//单选
                
                for (QdtFilterBaseModel *model in FilterLeftTableSelectingModel.secondaryCategorys) {
                    model.selected = NO;
                }
                FilterRightTableSelectingModel.selected = YES;
                [self.rightTableView reloadData];
                FilterLeftTableSelectingModel.mainCategory.selected = YES;
                [self reloadLeftTableView];
                
                //判断是否添加到collection,刷新
                for (NSInteger i = 0; i < self.collects.count; i ++) {
                    if ([self.collects[i].title isEqualToString:title]) {
                        self.collects[i] = collect;
                        [self reloadCollectionView];
                        return;
                    }
                }
                
                [self.collects addObject:collect];
                [self reloadCollectionView];
            }
        }
    }
}

#pragma mark- collection Delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section{
    return self.collects.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QdtFilterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FilterCollectionCellIdentifier forIndexPath:indexPath];
    cell.grayStyle = self.fliterHasHidden;
    cell.collectModel = self.collects[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //清除打钩状态
    self.collects[indexPath.row].selectedModel.selected = NO;
    for (QdtFilterCategory *category in self.categorys) {
        if ([category.mainCategory.Name isEqualToString:self.collects[indexPath.row].title]) {
            category.mainCategory.selected = [self checkRightTableSelectState:category.secondaryCategorys];
        }
    }
    [self reloadLeftTableView];
    [self.rightTableView reloadData];
    //移除
    [self.collects removeObjectAtIndex:indexPath.row];
    [self reloadCollectionView];
    
}

#pragma mark - event

- (IBAction)resetting:(UIButton *)sender {
    
    for (QdtFilterCategory *category in self.categorys) {
        category.mainCategory.selected = NO;
        for (QdtFilterBaseModel *m in category.secondaryCategorys) {
            m.selected = NO;
        }
    }
    [self.collects removeAllObjects];
    self.leftSelectingIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self reloadLeftTableView];
    [self reloadCollectionView];
    [self.rightTableView reloadData];
}


- (IBAction)confirm:(UIButton *)sender {
    [self hiddenFilter];
}

- (IBAction)tapBlackMaskView:(UIButton *)sender {
    [self hiddenFilter];
}

#pragma mark- function-private
- (void)reloadCollectionView{
    //判断是否显示collectionView
    NSInteger constant = 0;
    if (self.collects.count > 0) {
        constant = 0;
    } else{
        constant = -60;
    }
    if (self.collectionViewTopConstraint.constant != constant) {
        self.collectionViewTopConstraint.constant = constant;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    [self.collectionView reloadData];
    if (self.collects.count >3) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(self.collects.count - 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

- (void)reloadLeftTableView{
    [self.leftTableView reloadData];
    [self.leftTableView selectRowAtIndexPath:self.leftSelectingIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.leftTableView scrollToRowAtIndexPath:self.leftSelectingIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (BOOL)checkRightTableSelectState:(NSArray<QdtFilterBaseModel *> *)secondaryCategorys{
    for (QdtFilterBaseModel *model in secondaryCategorys) {
        if (model.selected == YES) {
            return YES;
        }
    }
    return NO;
}

#pragma mark- function-public

- (void)showFilterCompletion:(QdtFilterCompletionBlock)completion{
    self.view.frame = CGRectMake(self.filterFrame.origin.x, self.filterFrame.origin.y, self.filterFrame.size.width, self.view.superview.frame.size.height);
    self.collectionView.allowsSelection = YES;
    self.completionBlcok = completion;
    self.fliterHasHidden = NO;
    [self.collectionView reloadData];
}

- (void)hiddenFilter{
    if (self.collects.count > 0) {
        self.view.frame = CGRectMake(self.filterFrame.origin.x, self.filterFrame.origin.y, self.filterFrame.size.width, 60);
    } else{
        self.view.frame = CGRectZero;
    }
    self.collectionView.allowsSelection = NO;
    self.fliterHasHidden = YES;
    [self.collectionView reloadData];
    self.completionBlcok(self.collects);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
