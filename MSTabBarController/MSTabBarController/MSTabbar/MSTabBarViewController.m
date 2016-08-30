//
//  MSTabBarViewController.m
//  MSTabBarController
//
//  Created by miss on 16/8/30.
//  Copyright © 2016年 mukr. All rights reserved.
//


#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#import "MSTabBarViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@interface MSTabBarViewController ()<MSTabBarViewDelegate,UINavigationControllerDelegate>

@end

@implementation MSTabBarViewController

#define kDocSCREEN_HEIGHT   50

- (void)viewDidLoad{
    [super viewDidLoad];

    [self addTabBarView];
    [self addChildViewControll];
    [self addItem];
    
}

- (void)addTabBarView{
 
    MSTabBarView *tabBarView = [[MSTabBarView alloc] init];
    tabBarView.frame = CGRectMake(0,SCREEN_HEIGHT-kDocSCREEN_HEIGHT,SCREEN_WIDTH,kDocSCREEN_HEIGHT);
    tabBarView.delegate = self;
    [self.view addSubview:tabBarView];
    _tabBarView = tabBarView;
    
}

#pragma Mark dock代理方法
-(void)dock:(MSTabBarView *)dock itemSelectedFrom:(NSInteger)from to:(NSInteger)to
{
        
    if(to<0 || to>=self.childViewControllers.count) return;
    
    //0移除旧的控制器
    UIViewController *oldVx=self.childViewControllers[from];
    [oldVx.view removeFromSuperview];
    
    //1.取出即将显示的控制器
    UIViewController *newVc=self.childViewControllers[to];
    CGFloat width=SCREEN_WIDTH;
    //CGFloat height=SCREEN_HEIGHT-kDocSCREEN_HEIGHT;
    newVc.view.frame=CGRectMake(0,0,width,SCREEN_HEIGHT);
    
    //2.添加新控制器的View到MainControll上面
    [self.view addSubview:newVc.view];
    [self.view bringSubviewToFront:_tabBarView];
    _selectedController = newVc;
}

-(void)addChildViewControll
{
    //1.
    FirstViewController *first = [[FirstViewController alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
    firstNav.delegate = self;
    [self addChildViewController:firstNav];
    
    //2.
    SecondViewController *second =[[SecondViewController alloc] init];
    UINavigationController *secondNav=[[UINavigationController alloc] initWithRootViewController:second];
    secondNav.delegate = self;
    [self addChildViewController:secondNav];
    
    //3.
    ThirdViewController *third=[[ThirdViewController alloc] init];
    UINavigationController *thirdNav=[[UINavigationController alloc] initWithRootViewController:third];
    thirdNav.delegate = self;
    [self addChildViewController:thirdNav];
    
    //4.
    FourthViewController *fourthVC=[[FourthViewController alloc] init];
    UINavigationController *fourthNav=[[UINavigationController alloc] initWithRootViewController:fourthVC];
    fourthNav.delegate = self;
    [self addChildViewController:fourthNav];
    
}

#pragma mark  UInavgationDelegate
//导航控制器即将展示新的控制器
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    UIViewController *root=navigationController.viewControllers[0];
    if(root!=viewController){ //不是根控制器
        //如果显示的不是根控制器，就需要拉长导航控制器View的高度
        CGRect frame=navigationController.view.frame;
        frame.size.height=[UIScreen mainScreen].bounds.size.height;//除去状态栏的高度
        navigationController.view.frame=frame;
        
        // 添加Dock到跟控制器的View上面
        [_tabBarView removeFromSuperview];
        CGRect dockFrame=_tabBarView.frame;
        dockFrame.origin.y=root.view.frame.size.height-_tabBarView.frame.size.height;
        
        if([root.view isKindOfClass:[UIScrollView class]]){
            UIScrollView *scroller=(UIScrollView *)root.view;
            dockFrame.origin.y+=scroller.contentOffset.y;
        }
        //调整dock 的y 值
        _tabBarView.frame = dockFrame;
        [root.view addSubview:_tabBarView];
        
    }
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *root = navigationController.viewControllers[0];
    if (root==viewController) {
        // 1.让导航控制器view的高度还原
        CGRect frame = navigationController.view.frame;
        frame.size.height = [UIScreen mainScreen].bounds.size.height - _tabBarView.frame.size.height;
        navigationController.view.frame = [UIScreen mainScreen].bounds;
        
        // 2.添加Dock到根控制器的View上面
        [_tabBarView removeFromSuperview];
        CGRect dockFrame = _tabBarView.frame;
        // 调整dock的y值
        dockFrame.origin.y = self.view.frame.size.height - _tabBarView.frame.size.height;
        
        [self.view addSubview:_tabBarView];
        
        
    }
    
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
//        viewController.navigationController.delegate = viewController;
//    viewController.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}



- (void)addItem {
    // 2.往Dock  里面填充内容
    _tabBarView.count = 4;
    [_tabBarView addItemWithIcon:@"http://www.mukr.com/public/attachment/201604/06/11/sy_icon1101.png" selectedIcon:@"http://www.mukr.com/public/attachment/201604/06/11/sy_icon2201.png" title:@"首页" andSelectedTitleColor:[UIColor redColor] index:0 netImage:YES];
    [_tabBarView addItemWithIcon:@"tabbar_xiangmu" selectedIcon:@"tabbar_xiangmu_pink" title:@"项目" andSelectedTitleColor:[UIColor redColor] index:1 netImage:NO];
    [_tabBarView addItemWithIcon:@"http://www.mukr.com/public/attachment/201604/06/11/sy_icon1101.png" selectedIcon:@"http://www.mukr.com/public/attachment/201604/06/11/sy_icon2201.png" title:@"发现" andSelectedTitleColor:[UIColor redColor] index:2 netImage:YES];
    [_tabBarView addItemWithIcon:@"tabbar_wo" selectedIcon:@"tabbar_wo_pink" title:@"我" andSelectedTitleColor:[UIColor redColor] index:3 netImage:NO];
    
}

@end
