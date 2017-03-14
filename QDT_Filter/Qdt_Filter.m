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

@interface Qdt_Filter ()<UITableViewDelegate,
                         UITableViewDataSource,
                         UICollectionViewDelegate,
                         UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation Qdt_Filter

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FilterLeftTableCellIdentifier];
    [self.rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FilterRightTableCellIdentifier];
    self.leftTableView.tableFooterView = [UIView new];
    self.rightTableView.tableFooterView = [UIView new];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(80, 50);
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    [self.collectionView setCollectionViewLayout:layout];
    [self.collectionView registerClass:[QdtFilterCollectionCell class] forCellWithReuseIdentifier:FilterCollectionCellIdentifier];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return self.categorys.count;
    } else{
        NSIndexPath *index = [[self.leftTableView indexPathsForSelectedRows] firstObject];
        return self.categorys[index.row].secondaryCategorys.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        
        UITableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:FilterLeftTableCellIdentifier forIndexPath:indexPath];
        leftCell.textLabel.text = self.categorys[indexPath.row].mainCategory.Name;
        return leftCell;
        
    } else{
        
        UITableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:FilterRightTableCellIdentifier forIndexPath:indexPath];
        NSIndexPath *index = [[self.leftTableView indexPathsForSelectedRows] firstObject];
        rightCell.textLabel.text = self.categorys[index.row].secondaryCategorys[indexPath.row].Name;
        return rightCell;
    
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        [self.rightTableView reloadData];
    } else{
        
    }
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView
                cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QdtFilterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FilterCollectionCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
