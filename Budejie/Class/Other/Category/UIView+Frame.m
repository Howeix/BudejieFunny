//
//  UIView+Frame.m
//  Budejie
//
//  Created by 黄炜 on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

+(instancetype)hw_viewFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

-(void)setHw_x:(CGFloat)hw_x{
    CGRect rect = self.frame;
    rect.origin.x = hw_x;
    self.frame = rect;
}

-(void)setHw_y:(CGFloat)hw_y{
    CGRect rect = self.frame;
    rect.origin.y = hw_y;
    self.frame = rect;
}
-(void)setHw_centerX:(CGFloat)hw_centerX{
    CGPoint point = self.center;
    point.x = hw_centerX;
    self.center = point;
}

-(void)setHw_centerY:(CGFloat)hw_centerY{
    CGPoint point = self.center;
    point.y = hw_centerY;
    self.center = point;
}

-(void)setHw_width:(CGFloat)hw_width{
    CGRect rect = self.frame;
    rect.size.width = hw_width;
    self.frame = rect;
}

-(void)setHw_height:(CGFloat)hw_height{
    CGRect rect = self.frame;
    rect.size.height = hw_height;
    self.frame = rect;
}

//width
-(CGFloat)hw_width{
    return self.frame.size.width;
}

//height
-(CGFloat)hw_height{
    return self.frame.size.height;
}

//x
-(CGFloat)hw_x{
    return self.frame.origin.x;
}

//y
-(CGFloat)hw_y{
    return self.frame.origin.y;
}

-(CGFloat)hw_centerX{
    return self.center.x;
}
-(CGFloat)hw_centerY{
    return self.center.y;
}

@end
