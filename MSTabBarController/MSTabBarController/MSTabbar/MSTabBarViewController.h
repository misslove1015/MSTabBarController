//
//  MSTabBarViewController.h
//  MSTabBarController
//
//  Created by miss on 16/8/30.
//  Copyright © 2016年 mukr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTabBarView.h"

@interface MSTabBarViewController : UIViewController

@property (nonatomic, strong) MSTabBarView *tabBarView;
@property (nonatomic, readonly, strong) UIViewController *selectedController;

@end
