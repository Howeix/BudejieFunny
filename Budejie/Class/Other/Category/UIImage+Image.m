//
//  UIImage+Image.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

/**
 返回一张没有被渲染的图片

 @param imageName 图片名称
 @return 一张没有被渲染的图片
 */
+(instancetype)imageOriginalWithName:(NSString *)imageName{
    UIImage *img = [self imageNamed:imageName];
    return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(instancetype)hw_circleImage{
    //1.开启图形上下文
    //比例因素:当前点与像素比例
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.设置裁剪区域
    [path addClip];
    //4.画图片
    [self drawAtPoint:CGPointZero];
    //5.取出图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

+(instancetype)hw_circleImageNamed:(NSString *)name{
    return [[self imageNamed:name] hw_circleImage];
}

@end
