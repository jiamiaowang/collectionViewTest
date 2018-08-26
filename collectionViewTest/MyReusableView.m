//
//  MyReusableView.m
//  collectionView
//
//  Created by 王佳苗 on 2018/6/30.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "MyReusableView.h"

@implementation MyReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self addSubview:self.displayLabel];
    }
    return self;
}
-(UILabel *)displayLabel{
    if(_displayLabel==nil){
        _displayLabel=[[UILabel alloc]initWithFrame:self.bounds];
        _displayLabel.textAlignment=NSTextAlignmentCenter;
        _displayLabel.textColor=[UIColor whiteColor];
        _displayLabel.backgroundColor=[UIColor redColor];
        
    }
    return _displayLabel;
}
@end
