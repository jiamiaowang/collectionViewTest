//
//  MyCell.m
//  collectionView
//
//  Created by 王佳苗 on 2018/6/30.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.layer.borderWidth=1.0f;
        self.layer.borderColor=[UIColor blackColor].CGColor;
//        self.layer.masksToBounds=YES;
        [self.contentView addSubview:self.displayLabel];
    }
    return self;
}
//懒加载
-(UILabel *)displayLabel{
    if(_displayLabel==nil){
        _displayLabel=[[UILabel alloc]initWithFrame:self.bounds];
        _displayLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _displayLabel;
}
@end
