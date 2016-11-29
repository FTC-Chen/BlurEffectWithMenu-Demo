//
//  BlurEffecViewController.m
//  BlurEffectWithMenu
//
//  Created by anyongxue on 2016/11/29.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "BlurEffecViewController.h"

@interface BlurEffecViewController ()

@property (nonatomic,strong)NSMutableArray *btArr;

@end

@implementation BlurEffecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //添加返回
    [self addBackGesture];
    
    //创建毛玻璃与按钮视图
    [self ceratViews];
    
}

- (void)addBackGesture{
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackAction)];
    
    [self.view addGestureRecognizer:tapGes];
}

//创建毛玻璃与按钮视图
- (void)ceratViews{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.81 green:0.81 blue:0.81 alpha:1];
    
    //毛玻璃
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualView.frame = self.view.bounds;
    
    [self.view addSubview:visualView];
    
    
    NSArray *btImgArr = @[@"addMatters",
                          @"addSchedule",
                          @"setupChat",
                          @"searchContacts"];
    
    NSArray *btTitleArr = @[@"添加事项",
                            @"添加日程",
                            @"发起会话",
                            @"查找联系人"];
    
    //创建button
    NSInteger sumColumns = 3;
    
    CGFloat btWidth = 80;
    CGFloat btHeight = 80;
    
    CGFloat edge = (self.view.frame.size.width - sumColumns * btWidth)/4;
    
    for (NSInteger i = 0; i<btImgArr.count; i++) {
        
        //行与列数
        CGFloat row = i / sumColumns;    //行
        
        CGFloat column = i % sumColumns;  //列
        
        
        CGFloat btX = edge+(edge+btWidth)*column;
        
        CGFloat btY = 80+(50+btWidth)*row;
        
        //--------button
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setFrame:CGRectMake(btX, -300, btWidth, btHeight)];
        
        [button setTag:i];
        
        [button setImage:[UIImage imageNamed:btImgArr[i]] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(btnClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];

        
        //--------label
        UILabel *label=[[UILabel alloc]init];
        
        [label setFrame:CGRectMake(btX, button.frame.origin.y+button.bounds.size.height+5, btWidth, 25)];
        
        [label setText:btTitleArr[i]];
        
        [label setTextColor:[UIColor grayColor]];
        
        [label setFont:[UIFont systemFontOfSize:14.0]];
        
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [label setTag:i];
        
        [self.view addSubview:label];

        
        //使用Spring Animation 特殊动画曲线,相关解释链接
        //http://www.renfei.org/blog/ios-8-spring-animation.html
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            //UIView animate动画:弹出添加按钮,从顶部弹到指定位置
            [UIView animateWithDuration:1.f delay:(0.2-0.02*i) usingSpringWithDamping:0.95f initialSpringVelocity:15.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                button.frame = CGRectMake(btX, btY, btWidth,btHeight);
                
                [label setFrame:CGRectMake(btX, button.frame.origin.y+button.bounds.size.height+5, btWidth, 25)];
                
            } completion:^(BOOL finished) {
                
                
            }];
            
        });
        
    }
}


//点击按钮动画
- (void)btnClickedAction:(UIButton *)sender{

    [self btAndLabelAnimation];
    
    NSLog(@"%ld",sender.tag);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //进入相对应的界面,此处我写为返回
        [self dismissViewControllerAnimated:YES completion:nil];
        
    });
}

//Spring Animation
- (void)btAndLabelAnimation{
    
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)view;
            
    
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                
                //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
                [UIView animateWithDuration:1.f delay:0.02*(btn.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    btn.frame = CGRectMake(btn.frame.origin.x, -300, btn.frame.size.width,btn.frame.size.height);
                    
                } completion:^(BOOL finished) {
                    
                }];
            });

        }
            

        if ([view isKindOfClass:[UILabel class]]) {
            
            UILabel *label=(UILabel *)view;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                //UIView animate动画:仿钉钉弹出添加按钮,从顶部弹到指定位置
                [UIView animateWithDuration:1.f delay:0.02*(label.tag) usingSpringWithDamping:0.6f initialSpringVelocity:1.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    [label setTextColor:[UIColor clearColor]];
                    
                } completion:^(BOOL finished) {
                    
                }];
            });

        }
        
        
    }

}


- (NSMutableArray *)btArr{
    
    if (!_btArr) {
        
        _btArr = [NSMutableArray array];
    }
    
    return _btArr;
}


- (void)tapBackAction{

    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
