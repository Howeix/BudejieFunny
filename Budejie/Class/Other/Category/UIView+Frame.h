//
//  UIView+Frame.h
//  Budejie
//
//  Created by 黄炜 on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat hw_width;
@property CGFloat hw_height;
@property CGFloat hw_x;
@property CGFloat hw_y;
@property CGFloat hw_centerX;
@property CGFloat hw_centerY;

+(instancetype)hw_viewFromXib;

@end
