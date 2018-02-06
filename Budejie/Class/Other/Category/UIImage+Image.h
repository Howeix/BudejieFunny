//
//  UIImage+Image.h
//  Budejie
//
//  Created by Jerry Huang on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+(instancetype)imageOriginalWithName:(NSString *)imageName;

-(instancetype)hw_circleImage;

+(instancetype)hw_circleImageNamed:(NSString *)name;

@end
