//
//  WaterFallController.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/6/30.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "WaterFallController.h"
#import "ImageCell.h"
#import "WaterFallFlowLayout.h"
@interface WaterFallController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFallFlowLayoutDelegate>
@property(nonatomic,strong)NSArray *images;
@end

@implementation WaterFallController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //设置为2列
    WaterFallFlowLayout *waterFall=[[WaterFallFlowLayout alloc]initWithColumnCount:2];
    waterFall.delegate=self;
    
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:waterFall];
    
    collectionView.dataSource=self;
    collectionView.delegate=self;
    [collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCell"];
    [self.view addSubview:collectionView];
    //加载图片
    [self initWithImages];
}

-(void)initWithImages{
    if(_images==nil){
        NSMutableArray *marray=[NSMutableArray array];
        for (int i=0; i<12; i++) {
            UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
            [marray addObject:image];
        }
        _images=marray;
    }
}


#pragma mark collectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.imageView.image=self.images[indexPath.item];
    return cell;
}
//根据图片的宽计算图片的高
-(CGFloat)heightWithImage:(UIImage *)image width:(CGFloat)width{
    return image.size.height*width/image.size.width;
}
-(CGFloat)getHeightWithFlowLayout:(WaterFallFlowLayout *)waterFallFloelayout width:(CGFloat)width index:(NSIndexPath *)indexPath{
    CGFloat height=[self heightWithImage:self.images[indexPath.item] width:width];
    return height;
}



//设置cell的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    CGFloat width=([[UIScreen mainScreen]bounds].size.width-self.flowLayout.minimumInteritemSpacing)/2;
//    return CGSizeMake(width, 180);
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
