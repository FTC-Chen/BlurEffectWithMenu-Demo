//
//  ViewController.m
//  BlurEffectWithMenu
//
//  Created by anyongxue on 2016/11/29.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ViewController.h"
#import "BlurEffecViewController.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ceratNaviBar];
    
}

- (void)ceratNaviBar{
    
    //创建右边导航栏
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(kScreenWidth-55, 12, 25, 25);
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"add2.png"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(menuAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

//弹出毛玻璃菜单,其实即是进入一个控制器
- (void)menuAction{

    BlurEffecViewController *blurVC = [[BlurEffecViewController alloc] init];
    
    blurVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    blurVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:blurVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
