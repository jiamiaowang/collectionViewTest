//
//  ViewController.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/6/28.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "ViewController.h"
#import "WaterFallController.h"
#import "CubeViewController.h"
#import "BallViewController.h"
#import "CardViewController.h"
#import "CommonViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *commonButton;
@property (weak, nonatomic) IBOutlet UIButton *waterFallButton;
@property (weak, nonatomic) IBOutlet UIButton *cubeButton;
@property (weak, nonatomic) IBOutlet UIButton *ballButton;
@property (weak, nonatomic) IBOutlet UIButton *cardButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.waterFallButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.waterFallButton.tag = 101;
    
    
    [self.cubeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.cubeButton.tag = 102;

    [self.ballButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.ballButton.tag = 103;
    
    [self.cardButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.cardButton.tag = 104;
    
    [self.commonButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.commonButton.tag = 105;
    
    
}
-(void)click:(UIButton *)sender{
    
    if (sender.tag == 101){
        WaterFallController * WVC  = [[WaterFallController alloc]init];
        [self.navigationController pushViewController:WVC animated:YES];
        
    }else if(sender.tag == 102){
        CubeViewController *cube=[[CubeViewController alloc]init];
        [self.navigationController pushViewController:cube animated:YES];
        
    }
    else if(sender.tag == 103){

        BallViewController * ball = [[BallViewController alloc]init];
        [self.navigationController pushViewController:ball animated:YES];
        
    }
    else if(sender.tag==104){
        CardViewController *card=[[CardViewController alloc]init];
        [self.navigationController pushViewController:card animated:YES];
    }
    else if(sender.tag==105){
        CommonViewController *common=[[CommonViewController alloc]init];
        [self.navigationController pushViewController:common animated:YES];
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
