//
//  CommonViewController.m
//  瀑布流布局
//
//  Created by 王佳苗 on 2018/7/1.
//  Copyright © 2018年 王佳苗. All rights reserved.
//

#import "CommonViewController.h"
#import "MyCell.h"
#import "MyReusableView.h"
enum{
    insertItemTag=100,
    deleteItemTag
};
@interface CommonViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    BOOL _selected;
    NSMutableArray *_dataSource;  //数据源
    NSMutableArray *_selectDataArray;  //选中的数据
}
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UICollectionViewFlowLayout *myFlowLayout;
@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initInterface];
    [self initDataSource];
    // Do any additional setup after loading the view, typically from a nib.
}
//初始化数据
-(void)initDataSource{
    _selectDataArray=[NSMutableArray array];
    _dataSource=[NSMutableArray array];
    for (int i=0; i<20; i++) {
        [_dataSource addObject:[NSString stringWithFormat:@"%d",i]];
    }
}
//初始化界面
-(void)initInterface{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.collectionView];
    
    //配置导航栏
    //插入
    UIBarButtonItem *insertItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(respondsButtonItem:)];
    insertItem.tag=insertItemTag;
//    self.navigationItem.rightBarButtonItem=insertItem;
    
    //删除
    UIBarButtonItem *deleteItem=[[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(respondsButtonItem:)];
    deleteItem.tag=deleteItemTag;
//    self.navigationItem.leftBarButtonItem=deleteItem;
    self.navigationItem.rightBarButtonItems=@[insertItem,deleteItem];
    
    //长按手势
    UILongPressGestureRecognizer *longGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(respondsGesture:)];
    [self.collectionView addGestureRecognizer:longGesture];
    
    
    
}

//长按手势响应
-(void)respondsGesture:(UILongPressGestureRecognizer *)gesture{
    //    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    //监听手势
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:{
            //获取手势长按位置
            NSIndexPath *indexPath= [self.collectionView indexPathForItemAtPoint:[gesture locationInView:self.collectionView]];
            //开始在特定的索引路径上对cell（单元）进行Interactive Movement（交互式移动工作）
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            
            break;
        case UIGestureRecognizerStateChanged:{
            //在手势作用期间更新交互移动的目标位置
            [self.collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:self.collectionView]];
        }
            break;
        case UIGestureRecognizerStateEnded:{
            //手势完成后，结束交互式移动
            [self.collectionView endInteractiveMovement];
            
        }
            break;
            
        default:{
            //默认情况下，取消交互式移动
            [self.collectionView cancelInteractiveMovement];
        }
            
            break;
    }
}

//导航栏按钮响应
-(void)respondsButtonItem:(UIBarButtonItem *)sender{
    switch (sender.tag) {
            //插入按钮
        case insertItemTag:{
            //弹出提示框
            UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示" message:@"请输入你要添加的数字" preferredStyle:UIAlertControllerStyleAlert];
            [alertController.view layoutIfNeeded];
            //输入文本
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.clearButtonMode=UITextFieldViewModeWhileEditing;
                textField.textAlignment=NSTextAlignmentCenter;
            }];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //获取输入的文本框
                UITextField *textField=alertController.textFields[0];
                //获取文本
                NSString *str=textField.text;
                
                if(str.length==0){
                    NSLog(@"请输入文本");
                    return ;
                }
                [_dataSource insertObject:str atIndex:0];
                [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
            
        }
            break;
            //删除按钮
        case deleteItemTag:{
            if([self.navigationItem.rightBarButtonItems[1].title isEqualToString:@"点击删除"]){
                NSLog(@"删除");
                for (NSString *data in _selectDataArray) {
                    [_dataSource removeObject:data];
                }
                [_selectDataArray removeAllObjects];
                //刷新
                [self.collectionView reloadData];
                self.collectionView.allowsSelection=NO;
                _collectionView.allowsMultipleSelection=NO;
            }
            //切换编辑状态
            _selected=!_selected;
            self.navigationItem.rightBarButtonItems[1].title=_selected?@"选择删除项":@"删除";
            if([self.navigationItem.rightBarButtonItems[1].title isEqualToString:@"选择删除项"]){
                //collectionView能选择
                self.collectionView.allowsSelection=YES;
                _collectionView.allowsMultipleSelection=YES;
            }
            
            
        }
            break;
            
        default:
            break;
    }
    
}
//懒加载collectionView
-(UICollectionView *)collectionView{
    if(_collectionView==nil){
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64) collectionViewLayout:self.myFlowLayout];
        
        _collectionView.backgroundColor=[UIColor brownColor];
        //设置是否允许滚动
        _collectionView.scrollEnabled=YES;
        //设置是否允许选中。默认为yes
        _collectionView.allowsSelection=NO;
        //设置是否能多选，默认为no
        //        _collectionView.allowsMultipleSelection=YES;
        
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        
        //注册item
        [_collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"myCell"];
        //注册头部视图
        [_collectionView registerClass:[MyReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerIndentifier"];
    }
    return _collectionView;
}
//懒加载flowLayout
-(UICollectionViewFlowLayout *)myFlowLayout{
    if(_myFlowLayout==nil){
        _myFlowLayout=[[UICollectionViewFlowLayout alloc]init];
        //设置item的大小
        _myFlowLayout.itemSize=CGSizeMake(100, 100);
        _myFlowLayout.minimumLineSpacing=5.0f;
        _myFlowLayout.minimumInteritemSpacing=5.0;
        //设置滚动方向
        _myFlowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        //设置头部大小
        _myFlowLayout.headerReferenceSize=CGSizeMake(CGRectGetWidth(self.view.bounds), 44);
        //设置是否当元素超出屏幕之后固定头部视图位置，默认NO
        _myFlowLayout.sectionHeadersPinToVisibleBounds=YES;
        
    }
    return _myFlowLayout;
}

#pragma mark collectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}
//设置单元格
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.displayLabel.backgroundColor=[UIColor whiteColor];
    cell.displayLabel.text=_dataSource[indexPath.item];
    return cell;
}

//自定义头部
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    // UICollectionElementKindSectionHeader：头部视图
    // UICollectionElementKindSectionFooter：尾部视图
    // 如果同时自定义头部、尾部视图，可根据 kind 参数判断当前加载的是头部还是尾部视图，然后进行相应配置。
    MyReusableView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerIndentifier" forIndexPath:indexPath];
    headerView .displayLabel.text=@"自定义视图";
    return headerView;
}
//设置是否能移动
-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//移动单元格
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    //    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSString *data=_dataSource[sourceIndexPath.item];
    [_dataSource removeObject:data];
    [_dataSource insertObject:data atIndex:destinationIndexPath.item];
    
    
}
//选中item
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _selected=YES;
    self.navigationItem.rightBarButtonItems[1].title=@"点击删除";
    MyCell *cell=(MyCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.displayLabel.backgroundColor=[UIColor greenColor];
    [_selectDataArray addObject:cell.displayLabel.text];
    
}
//取消选择item
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCell *cell=(MyCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.displayLabel.backgroundColor=[UIColor whiteColor];
    [_selectDataArray removeObject:cell.displayLabel.text];
    
}

#pragma mark collectionViewFlowLayout
//
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
