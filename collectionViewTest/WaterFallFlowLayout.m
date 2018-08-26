//
//  WaterFallFlowLayout.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/6/28.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "WaterFallFlowLayout.h"
@interface WaterFallFlowLayout()
{
    int columnCount;//列数
}
@property(nonatomic,strong)NSMutableDictionary *maxHeight;//每一列当前的最高度
@property(nonatomic,strong)NSMutableArray *arrtbutesArray;
@end
@implementation WaterFallFlowLayout
//
-(instancetype)initWithColumnCount:(int)count{
    if(self=[super init]){
        columnCount=count;
        self.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
        self.minimumInteritemSpacing=5;
        self.minimumLineSpacing=5;
    }
    return self;
}
//懒加载
-(NSMutableDictionary *)maxHeight{
    if(_maxHeight==nil){
        _maxHeight=[NSMutableDictionary dictionary];
        for (int i=0; i<columnCount; i++) {
            NSString *column=[NSString stringWithFormat:@"%d",i];
            _maxHeight[column]=@"0";
        }
    }
    return _maxHeight;
}
-(NSMutableArray *)arrtbutesArray{
    if(_arrtbutesArray==nil){
        _arrtbutesArray=[NSMutableArray array];
    }
    return _arrtbutesArray;
}
//初始化所有属性
-(void)prepareLayout{
    //初始化每列的Y坐标，开始在最顶端
    for (int i=0; i<columnCount; i++) {
        NSString *column=[NSString stringWithFormat:@"%d",i];
        self.maxHeight[column]=@(self.sectionInset.top);
    }
    [self.arrtbutesArray removeAllObjects];
    //查看有多少元素
    NSInteger count=[self.collectionView numberOfItemsInSection:0];
    //遍历每个item
    for ( int i=0; i<count; i++) {
        //取出布局元素
        UICollectionViewLayoutAttributes *arrt=[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        //添加到数组
        [self.arrtbutesArray addObject:arrt];
    }
}
//设置collectionView的contentSize
-(CGSize)collectionViewContentSize{
    __block NSString *maxColumn=@"0";
    //查找当前那一列的高度最大
    [self.maxHeight enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL * _Nonnull stop) {
        if([maxY floatValue]>[self.maxHeight[maxColumn] floatValue]){
            maxColumn=column;
        }
    }];
    return CGSizeMake(0, [self.maxHeight[maxColumn] floatValue]+self.sectionInset.bottom);
}
//设置所有cell的大小和位置
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return  self.arrtbutesArray;
}
//计算每个cell的大小和位置
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //判断现在哪一列的高度最小
    __block NSString *minColumn=@"0";
    [self.maxHeight enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *minY, BOOL * _Nonnull stop) {
        if([minY floatValue]<[self.maxHeight[minColumn] floatValue]){
            minColumn=column;
        }
    }];
    //计算每一个cell的frame
    CGFloat width=(self.collectionView.frame.size.width-self.sectionInset.left-self.sectionInset.right-self.minimumInteritemSpacing*(columnCount-1))/columnCount;
    CGFloat height=[self.delegate getHeightWithFlowLayout:self width:width index:indexPath];
    CGFloat x=self.sectionInset.left+(width+self.minimumInteritemSpacing)*[minColumn intValue];
    CGFloat y=[self.maxHeight[minColumn] floatValue]+self.minimumLineSpacing;
    self.maxHeight[minColumn]=@(y+height);
    
    UICollectionViewLayoutAttributes *arrt=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    arrt.frame=CGRectMake(x, y, width, height);
    
    return arrt;
    
}
@end
