//
//  MSTarBarView.m
//  MSTabBarController
//
//  Created by miss on 16/8/30.
//  Copyright © 2016年 mukr. All rights reserved.
//

#import "MSTabBarView.h"
#import "MSTabBarItem.h"
#import "UIButton+WebCache.h"

@interface MSTabBarView ()
{
    MSTabBarItem *_selectItem;
}
@end

@implementation MSTabBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //在tabbar顶部加一条横线
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.2)];
            label.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
            [self addSubview:label];
        });
       
        
    }
    return self;
}

- (void)addItemWithIcon:(NSString *)iconStr selectedIcon:(NSString *)selected title:(NSString *)title andSelectedTitleColor:(UIColor *)selectedTextColor index:(NSInteger)index netImage:(BOOL)isNetImage{
    //创建Item
    MSTabBarItem *item = [[MSTabBarItem alloc] init];
    item.backgroundColor = [UIColor whiteColor];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:selectedTextColor forState:UIControlStateSelected];
    if (isNetImage) {
        [item sd_setBackgroundImageWithURL:[NSURL URLWithString:iconStr] forState:UIControlStateNormal];
        [item sd_setBackgroundImageWithURL:[NSURL URLWithString:selected] forState:UIControlStateSelected];
    }else{
        [item setImage:[UIImage imageNamed:iconStr] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    }
   
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
    
    if(index == 0){
        [self itemClick:item];
    }
    
    CGFloat height = self.frame.size.height; 
    CGFloat width = self.frame.size.width/_count;
    item.tag = index;
    item.frame = CGRectMake(index*width, 0.2, width, height);
  
}


- (void)itemClick:(MSTabBarItem *)item{
   
    if([_delegate respondsToSelector:@selector(dock:itemSelectedFrom:to:)]){
        [_delegate dock:self itemSelectedFrom:_selectItem.tag to:item.tag];
    }
    
    //1.取消当前选中的Item
    _selectItem.selected = NO;
    //2.当前选中的Item
    item.selected = YES;
    //3.赋值
    _selectItem = item;
    //4.通知代理
    _selectIndex = _selectItem.tag;
    
}



@end
