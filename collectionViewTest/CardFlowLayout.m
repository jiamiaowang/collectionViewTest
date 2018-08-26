//
//  CardFlowLayout.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/7/1.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "CardFlowLayout.h"
@interface CardFlowLayout(){
    NSIndexPath *mainIndexPath;
    NSIndexPath *moveIndexPath;
}
@end
@implementation CardFlowLayout
-(void)prepareLayout{
    [super prepareLayout];
    CGFloat inset=self.collectionView.frame.size.width*(6/64.0f);
    inset=floor(inset);
    
    self.itemSize=CGSizeMake(self.collectionView.frame.size.width-(2*inset), self.collectionView.frame.size.height*3/4);
    
    self.sectionInset=UIEdgeInsetsMake(0, inset, 0, inset);
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *arrtributes=[super layoutAttributesForElementsInRect:rect];
    //获取当前可见的cell
    NSArray *cells=[self.collectionView indexPathsForVisibleItems];
    if(cells.count==0){
        return arrtributes;
    }
    else if(cells.count==1){
        mainIndexPath=cells.firstObject;
        moveIndexPath=nil;
    }
    else if(cells.count>1){
        NSIndexPath *firstIndexPath=cells.firstObject;
        if(mainIndexPath==firstIndexPath){
            moveIndexPath=cells[1];
        }
        else{
            moveIndexPath=firstIndexPath;
            mainIndexPath=cells[1];
        }
    }
    for (UICollectionViewLayoutAttributes *arrt in arrtributes) {
        [self transformToArrtributes:arrt];
    }
    return arrtributes;
}
-(void)transformToArrtributes:(UICollectionViewLayoutAttributes *)arrt{
    if(arrt.indexPath.section==mainIndexPath.section){
        UICollectionViewCell *cell=[self.collectionView cellForItemAtIndexPath:mainIndexPath];
        arrt.transform3D=[self transformForCell:cell];
    }
    else if(arrt.indexPath.section==moveIndexPath.section){
        UICollectionViewCell *cell=[self.collectionView cellForItemAtIndexPath:moveIndexPath];
        arrt.transform3D=[self transformForCell:cell];
    }
}
-(CATransform3D)transformForCell:(UICollectionViewCell *)cell{
    CATransform3D trans3d=CATransform3DIdentity;
    CGFloat angel=[self angelForCell:cell];
    BOOL xAxis=[self xAxisForCell:cell];
    if(xAxis){
        trans3d=CATransform3DRotate(trans3d, angel, 1, 1, 0);
    }
    else{
        trans3d=CATransform3DRotate(trans3d, angel, -1, 1, 0);
    }
    return trans3d;
    
}
-(CGFloat)angelForCell:(UICollectionViewCell *)cell{
    CGFloat offset=[self baseOffsetForCell:cell];
    CGFloat currentOffset=self.collectionView.contentOffset.x;
    CGFloat angel=(currentOffset-offset)/self.collectionView.frame.size.width;
    return angel;
}
-(CGFloat)baseOffsetForCell:(UICollectionViewCell *)cell{
    CGFloat offset=[self.collectionView indexPathForCell:cell].section*self.collectionView.frame.size.width;
    return offset;
}
-(BOOL)xAxisForCell:(UICollectionViewCell *)cell{
    CGFloat offset=[self baseOffsetForCell:cell];
    CGFloat currentOffset=self.collectionView.contentOffset.x;
    if(currentOffset-offset>=0)
        return YES;
    return NO;
}
@end
