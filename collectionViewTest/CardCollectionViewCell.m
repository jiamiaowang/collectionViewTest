//
//  CardCollectionViewCell.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/7/1.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "CardCollectionViewCell.h"

@implementation CardCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
//        self.layer.borderColor=[UIColor blackColor].CGColor;
//        self.layer.borderWidth=3.0f;
        [self.layer setCornerRadius:20.f];
        [self.layer setMasksToBounds:YES];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
-(UIImageView *)imageView{
    if(_imageView==nil){
        _imageView=[[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _imageView;
}
@end
