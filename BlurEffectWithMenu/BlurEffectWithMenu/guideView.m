//
//  guideView.m
//  BlurEffectWithMenu
//
//  Created by anyongxue on 2016/11/30.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "guideView.h"

@interface guideView ()<UIScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray *imageArr;

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UIPageControl *pageCtrl;

@end


@implementation guideView


- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];

    if (self) {
        
        self.imageArr = [NSMutableArray arrayWithObjects:@"guide1",@"guide2",@"guide3",@
                         "guide4",nil];
        
        //创建scrollView
        [self creatScrollView];
        
    }
 
    return self;
    
}

- (void)creatScrollView{
    
    //创建scrollView
    self.scrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollView.contentSize = CGSizeMake((self.imageArr.count+1)*kScreenWidth, kScreenHeight);
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.bounces = NO;//反弹,反向拖动效果
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView.delegate = self;
    
    [self addSubview:self.scrollView];
    
    
    //添加imgView
    for (int i = 0; i<self.imageArr.count; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        
        imgView.frame = CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight);
        
        imgView.image = [UIImage imageNamed:self.imageArr[i]];
        
        [self.scrollView addSubview:imgView];
    }
    
    //创建pageCtrl
    self.pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenWidth/2, kScreenHeight-60, 0, 40)];
    
    self.pageCtrl.numberOfPages = self.imageArr.count;
    
    self.pageCtrl.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.pageCtrl];
    
    
    
    //添加手势 可设置一个背景为点击范围
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    
    tapGes.numberOfTapsRequired = 1;
    
    [self.scrollView addGestureRecognizer:tapGes];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.scrollView) {
        
        CGPoint offset = scrollView.contentOffset;
        
        //设置pageCtrl
        self.pageCtrl.currentPage = offset.x/(self.bounds.size.width);//当前页码
        
        [scrollView setContentOffset:CGPointMake(self.bounds.size.width*self.pageCtrl.currentPage, offset.y) animated:YES];
        
    }
    
    //超过时隐藏/移除
    if (scrollView.contentOffset.x == (self.imageArr.count) *(kScreenWidth)) {
        
        //进入相对应的界面,此处我写为返回
        self.hidden = YES;
            
        [self removeFromSuperview];
        
    }
}


//最后一页点击隐藏
- (void)tapAction{
    
    if (self.pageCtrl.currentPage == 3) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //进入相对应的界面,此处我写为返回
            self.hidden = YES;
            
            [self removeFromSuperview];
            
        });

    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
