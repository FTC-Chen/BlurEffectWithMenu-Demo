//
//  ViewController.m
//  BlurEffectWithMenu
//
//  Created by anyongxue on 2016/11/29.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "ViewController.h"
#import "BlurEffecViewController.h"

#import "MBProgressHUD.h"

#import "SVProgressHUD.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define KVIEWBGColor [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]

@interface ViewController ()

@property (nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KVIEWBGColor;
    
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


//测试MBProgressHUD
- (IBAction)testHudAction:(id)sender {

    /*
     要将一个MBProgressHUD显示出来，1，创建对象；2，将HUD添加到view上；3，调用show方法
     隐藏，1，hide:方法；  2，hide: afterDelay: 方法
     其它的用法都是特殊的设置等
     */
    
    self.HUD = [[MBProgressHUD alloc] init];
    
    //Demo方法
    // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
//    self.HUD.mode = MBProgressHUDModeIndeterminate;//菊花，默认值
//    self.HUD.mode = MBProgressHUDModeDeterminate;//圆饼，饼状图
//    self.HUD.mode = MBProgressHUDModeDeterminateHorizontalBar;//进度条
//    self.HUD.mode = MBProgressHUDModeAnnularDeterminate;//圆环作为进度条
    self.HUD.mode = MBProgressHUDModeCustomView; //需要设置自定义视图时候设置成这个
//    self.HUD.mode = MBProgressHUDModeText; //只显示文本
    
    //----- customView
    
    /*
     1.UIImageRenderingModeAutomatic    // 根据图片的使用环境和所处的绘图上下文自动调整渲染模式。
     2.UIImageRenderingModeAlwaysOriginal // 始终绘制图片原始状态，不使用Tint Color。
     3.UIImageRenderingModeAlwaysTemplate // 始终根据Tint Color绘制图片，忽略图片的颜色信息。
     */
    
    UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.HUD.customView = [[UIImageView alloc] initWithImage:image];
    
    self.HUD.customView.tintColor = [UIColor redColor];//原本图片黑色,使用tint后变成红色
    
    // Looks a bit nicer if we make it square.
    self.HUD.square = YES;

    [self.view addSubview:self.HUD];
    
    [self.HUD showAnimated:YES];
    
    //圆环进度条下载时用
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//        // Do something useful in the background and update the HUD periodically.
//        [self doSomeWorkWithProgress];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.HUD hideAnimated:YES];
//        });
//    });
    
    
    //设置hud相关属性
    //1,设置背景框的透明度  现在透明度为1
    
//    NSLog(@"~~~~ > %f",self.HUD.opacity);
//    NSLog(@"---- > %f",self.HUD.bezelView.alpha);
//    NSLog(@"//// > %f",self.HUD.bezelView.layer.opacity);
    
    self.HUD.bezelView.alpha = 0.8;
    
    //2,设置背景框的背景颜色和透明度， 设置背景颜色之后opacity属性的设置将会失效
//    self.HUD.bezelView.color = [UIColor redColor];
//    self.HUD.bezelView.color = [self.HUD.bezelView.color colorWithAlphaComponent:1];
    
    //3,设置背景框的圆角值，默认是5
//    NSLog(@"~~~~ > %f",self.HUD.cornerRadius);
//    self.HUD.cornerRadius = 10.0;
//    self.HUD.cornerRadius = 20.0;
    
    //4,设置提示信息 信息颜色，字体
//    self.HUD.labelColor = [UIColor blueColor];
//    self.HUD.label.font = [UIFont systemFontOfSize:14];
//    self.HUD.label.text = @"Loading...";
    self.HUD.label.text = NSLocalizedString(@"Completed", nil);
    
    //5,设置提示信息详情 详情颜色，字体   默认detail字体比hud.label.字体要小
//    self.HUD.detailsLabelColor = [UIColor blueColor];
//    self.HUD.detailsLabel.font = [UIFont systemFontOfSize:13];
//    self.HUD.detailsLabel.text = @"请稍后...";
    
    //6，设置菊花颜色  只能设置菊花的颜色
    //self.HUD.activityIndicatorColor = [UIColor redColor]; //旧
    //[UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor redColor];
    
    //7,设置一个渐变层
    //self.HUD.dimBackground = YES; //旧
    //self.HUD.backgroundView.backgroundColor = [UIColor redColor];//新
    
    //8,设置动画的模式
//    self.HUD.mode = MBProgressHUDModeIndeterminate;
    
    //9，设置提示框的相对于父视图中心点的便宜，正值 向右下偏移，负值左上
    //self.HUD.xOffset = -80;
    //self.HUD.yOffset = -100;
   
    //10，设置各个元素距离矩形边框的距离
//    self.HUD.margin = 0;
    
    //11，背景框的最小大小
    //self.HUD.minSize = CGSizeMake(50, 50);
    
    //12设置背景框的实际大小   readonly
    //CGSize size = self.HUD.size;
    
    //13,是否强制背景框宽高相等
//    self.HUD.square = NO;
    
    //14,设置显示和隐藏动画类型  有三种动画效果，如下
//    self.HUD.animationType = MBProgressHUDAnimationFade; //默认类型的，渐变
//    self.HUD.animationType = MBProgressHUDAnimationZoom;
//    self.HUD.animationType = MBProgressHUDAnimationZoomOut;
//    self.HUD.animationType = MBProgressHUDAnimationZoomIn;

    //15,设置最短显示时间，为了避免显示后立刻被隐藏   默认是0
//    self.HUD.minShowTime = 10;
    
    //16,
    /*
     // 这个属性设置了一个宽限期，它是在没有显示HUD窗口前被调用方法可能运行的时间。
     // 如果被调用方法在宽限期内执行完，则HUD不会被显示。
     // 这主要是为了避免在执行很短的任务时，去显示一个HUD窗口。
     // 默认值是0。只有当任务状态是已知时，才支持宽限期。具体我们看实现代码。
     @property (assign) float graceTime;
     
     // 这是一个标识位，标明执行的操作正在处理中。这个属性是配合graceTime使用的。
     // 如果没有设置graceTime，则这个标识是没有太大意义的。在使用showWhileExecuting:onTarget:withObject:animated:方法时，
     // 会自动去设置这个属性为YES，其它情况下都需要我们自己手动设置。
     @property (assign) BOOL taskInProgress;
     */
    
    //17,设置隐藏的时候是否从父视图中移除，默认是NO
//    self.HUD.removeFromSuperViewOnHide = YES;
    
    //18,进度指示器  模式是0，取值从0.0————1.0
    //self.HUD.progress = 0.5;
    
    
    //19,隐藏时候的回调 隐藏动画结束之后
    self.HUD.completionBlock = ^(){
        
        NSLog(@"111111111");
    };
    
    
    //自带隐藏方法
    [self.HUD hideAnimated:YES afterDelay:3.0f];
    
    //延时隐藏
    //[self performSelector:@selector(hideHudAction) withObject:self afterDelay:3.0f];
    
}

- (void)hideHudAction{
    
    //[self.HUD hideAnimated:YES];
    
    [SVProgressHUD dismiss];
}

- (void)doSomeWorkWithProgress {
    //self.canceled = NO;
    // This just increases the progress indicator in a loop.
    float progress = 0.0f;
    while (progress < 1.0f) {
        //if (self.canceled) break;
        progress += 0.01f;
        dispatch_async(dispatch_get_main_queue(), ^{
            // Instead we could have also passed a reference to the HUD
            // to the HUD to myProgressTask as a method parameter.
            
            //self.HUD.progress = progress;

        });
        usleep(50000);
    }
}

- (IBAction)testSVHUDAction:(id)sender {
    
    [SVProgressHUD show];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // time-consuming task
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//    });
    
    //增加文字
//    [SVProgressHUD showWithStatus:@"Loading..."];//默认是没有文字状态
    //进度
    [SVProgressHUD showProgress:0.3];

    //增加提示图片
    //[SVProgressHUD showInfoWithStatus:@"Loading..."]; //感叹号❗️图片
    //成功信息
    [SVProgressHUD showSuccessWithStatus:@"完成"];
    //失败信息
    [SVProgressHUD showErrorWithStatus:@"失败"];
    //图片
     UIImage *image = [[UIImage imageNamed:@"Checkmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [SVProgressHUD showImage:image status:@"Completed"];
    
    //自定义信息
    //样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];//默认是SVProgressHUDStyleLight
    
    //聚焦遮罩
    //[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];//默认是None
    
    //动画样式
    //[SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    
    //[SVProgressHUD setRingThickness:10];//默认是2  圆环厚度/效果?
    
    //[SVProgressHUD setCornerRadius:14]; //默认是14
    
    //[SVProgressHUD setFont:<#(UIFont *)#>];//默认是 [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
    
    //[SVProgressHUD setForegroundColor:<#(UIColor *)#>];//默认是 [UIColor blackColor], 仅对 SVProgressHUDStyleCustom 有效
    
    //[SVProgressHUD setBackgroundColor:<#(UIColor *)#>];//默认是 [UIColor whiteColor], 仅对 SVProgressHUDStyleCustom 有效
    
    //[SVProgressHUD setInfoImage:<#(UIImage *)#>];//默认是bundle文件夹中的提示图片.
    
    //setSuccessImage / setErrorImage  /
    
    //setViewForExtension ? 默认是nil,仅当设置了 #define SV_APP_EXTENSIONS 时有效.
    //[SVProgressHUD setViewForExtension:<#(UIView *)#>]
    
    
    /*
     SVProgressHUD通过 NSNotificationCenter 注册4份通知,以响应正在显示/消失:
     SVProgressHUDWillAppearNotification 提示框即将出现
     SVProgressHUDDidAppearNotification 提示框已经出现
     SVProgressHUDWillDisappearNotification 提示框即将消失
     SVProgressHUDDidDisappearNotification 提示框已经消失
    
     每个通知传递一个 userInfo字典,字典中包含HUD的状态字符串（如果有的话） ，可通过 SVProgressHUDStatusUserInfoKey作为键来获取。
     
     SVProgressHUD还发送通知:
     SVProgressHUDDidReceiveTouchEventNotification当用户触摸整体屏幕上 和
     ' SVProgressHUDDidTouchDownInsideNotification当用户直接在HUD接触。这两个通知没有 userInfo参数，但包含了有关的触摸的UIEvent` 参数. 
     
     //触摸屏幕时或者触摸hud时进行操作
     */
  
    /*
     App 扩展(App Extension)
     当在应用程序中使用SVProgressHUD时， 要定义常量 #define SV_APP_EXTENSIONS避免使用不可用的API。然后从你的扩展视图控制器中通过self.view 调用 setViewForExtension: 即可。
     注意: 此处指的是"App Extension",不是类目."File->New->Target...-> iOS -> App Extension->Photo Editing Extension". 如果未用到,可忽略. 更多细节参考: https://github.com/TransitApp/SVProgressHUD/issues/390
     */
    
    
    
    //延时隐藏
    [self performSelector:@selector(hideHudAction) withObject:self afterDelay:3.0f];

    //[SVProgressHUD dismissWithDelay:5.0f];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
