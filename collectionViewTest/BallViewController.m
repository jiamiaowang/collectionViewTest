//
//  BallViewController.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/7/1.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "BallViewController.h"
#import "BallFlowLayout.h"
@interface BallViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *_collectionView;
}
@end

@implementation BallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BallFlowLayout *flowLayout=[[BallFlowLayout alloc]init];
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(30, 50, 320, 400) collectionViewLayout:flowLayout];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cells"];
    [self.view addSubview:_collectionView];
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[_collectionView dequeueReusableCellWithReuseIdentifier:@"cells" forIndexPath:indexPath];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    label.text=[NSString stringWithFormat:@"%ld",(long)indexPath.item];
    cell.backgroundColor=[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<200) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y+10*400);
    }else if(scrollView.contentOffset.y>11*400){
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y-10*400);
    }
    if (scrollView.contentOffset.x<160) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x+10*320,scrollView.contentOffset.y);
    }else if(scrollView.contentOffset.x>11*320){
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x-10*320,scrollView.contentOffset.y);
    }
    
}
@end
