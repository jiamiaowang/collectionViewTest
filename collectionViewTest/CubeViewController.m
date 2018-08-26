//
//  CubeViewController.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/6/30.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "CubeViewController.h"
#import "CubeFlowLayout.h"
@interface CubeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}
@end

@implementation CubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
//    flowLayout.itemSize=CGSizeMake(100, 100);
//    flowLayout.minimumLineSpacing=5;
//    flowLayout.minimumInteritemSpacing=5;
//    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    
    CubeFlowLayout *flowLayout=[[CubeFlowLayout alloc]init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(30, 50, 320, 400) collectionViewLayout:flowLayout];
   
    
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cells"];
    
    [self.view addSubview:_collectionView];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[_collectionView dequeueReusableCellWithReuseIdentifier:@"cells" forIndexPath:indexPath];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 80)];
    label.text=[NSString stringWithFormat:@"第%ld行",(long)indexPath.item];
    [cell.contentView addSubview:label];
    cell.backgroundColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y<400){
        scrollView.contentOffset=CGPointMake(0, scrollView.contentOffset.y+9*400);
    }
    else if(scrollView.contentOffset.y>10*400){
        scrollView.contentOffset=CGPointMake(0, scrollView.contentOffset.y-9*400);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
