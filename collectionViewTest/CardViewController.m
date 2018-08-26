//
//  CardViewController.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/7/1.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "CardViewController.h"
#import "CardFlowLayout.h"
#import "CardCollectionViewCell.h"
@interface CardViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *_collectionView;
}
@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CardFlowLayout *flowLayout=[[CardFlowLayout alloc]init];
    
    _collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.pagingEnabled=YES;
    _collectionView.clipsToBounds=YES;
    
    [_collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:@"cells"];
    _collectionView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CardCollectionViewCell *cell=[_collectionView dequeueReusableCellWithReuseIdentifier:@"cells" forIndexPath:indexPath];
    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}
-(void)configureCell:(CardCollectionViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            cell.imageView.image=[UIImage imageNamed:@"4"];
            break;
        case 1:
            cell.imageView.image=[UIImage imageNamed:@"5"];
            break;
        case 2:
            cell.imageView.image=[UIImage imageNamed:@"7"];
            break;
        case 3:
            cell.imageView.image=[UIImage imageNamed:@"8"];
            break;

            
        default:
            break;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
