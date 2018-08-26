//
//  WaterFallFlowLayout.h
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/6/28.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFallFlowLayout;
@protocol WaterFallFlowLayoutDelegate <NSObject>

-(CGFloat)getHeightWithFlowLayout:(WaterFallFlowLayout *)waterFallFloelayout width:(CGFloat)width index:(NSIndexPath *)indexPath;
@end


@interface WaterFallFlowLayout : UICollectionViewFlowLayout
-(instancetype)initWithColumnCount:(int)count;
@property(nonatomic,weak)id<WaterFallFlowLayoutDelegate> delegate;
@end
