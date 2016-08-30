//
//  MSTarBarView.h
//  MSTabBarController
//
//  Created by miss on 16/8/30.
//  Copyright © 2016年 mukr. All rights reserved.
//


#import <UIKit/UIKit.h>

@class MSTabBarView;

@protocol MSTabBarViewDelegate <NSObject>

@optional
- (void)dock:(MSTabBarView *)dock itemSelectedFrom:(NSInteger)from to:(NSInteger) to;

@end

@interface MSTabBarView : UIView

//添加使用本地图片的item
- (void)addItemWithIcon:(NSString *)iconStr selectedIcon:(NSString *)selected title:(NSString *)title andSelectedTitleColor:(UIColor *)selectedTextColor index:(NSInteger)index netImage:(BOOL)isNetImage;

@property (nonatomic,weak) id<MSTabBarViewDelegate> delegate;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,assign) NSInteger count;
@end
