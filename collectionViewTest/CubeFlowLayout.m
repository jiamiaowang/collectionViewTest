//
//  CubeFlowLayout.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/6/30.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "CubeFlowLayout.h"

@implementation CubeFlowLayout
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *arrtributes=[NSMutableArray array];
    //遍历设置每个item的属性
    for (int i=0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        [arrtributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
    }
    return arrtributes;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建一个item布局属性
    UICollectionViewLayoutAttributes *arrt=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //获取item的个数
    int itemCount=(int)[self.collectionView numberOfItemsInSection:0];
    //设置每个item的大小和中心
    arrt.size=CGSizeMake(260, 100);
    arrt.center=CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2+self.collectionView.contentOffset.y);
    
    CATransform3D trans3d=CATransform3DIdentity;
//    trans3d.m34=-1/500;
    //计算旋转角度
    //1、获取当前的偏移量
    float currentOffset=self.collectionView.contentOffset.y;
    //2、
    float angelOffset=currentOffset/self.collectionView.frame.size.height;
    float angel=(float)(indexPath.item+angelOffset-1)*2*M_PI/itemCount;
    trans3d=CATransform3DRotate(trans3d, angel, 1.0, 0, 0);
    //计算偏移量
    float offset=50/tanf(2*M_PI/itemCount/2);
    trans3d=CATransform3DTranslate(trans3d, 0, 0, offset);
    //设置
    arrt.transform3D=trans3d;
    
    return arrt;
}
//
-(CGSize)collectionViewContentSize{
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height*([self.collectionView numberOfItemsInSection:0]+1));
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
@end
