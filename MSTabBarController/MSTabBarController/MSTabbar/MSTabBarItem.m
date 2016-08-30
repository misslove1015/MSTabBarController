//
//  MSTabBarItem.m
//  MSTabBarController
//
//  Created by miss on 16/8/30.
//  Copyright © 2016年 mukr. All rights reserved.
//


#import "MSTabBarItem.h"
#define kTitleRatio            0.3

@implementation MSTabBarItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.imageView.contentMode = UIViewContentModeCenter;
        
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imgX = 0;
    CGFloat imgHeight = contentRect.size.height*(1-kTitleRatio);
    CGFloat imgY = -2;
    CGFloat imgWidth = contentRect.size.width;
    return CGRectMake(imgX,imgY,imgWidth,imgHeight);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height*kTitleRatio;;
    CGFloat titleY = contentRect.size.height-titleHeight-6;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX,titleY,titleWidth,titleHeight);
}


- (void)setHighlighted:(BOOL)highlighted{
//    if (highlighted) {
//        [self setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:alpha]];
//    }else{
//        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:alpha]];
//    }
}

@end
