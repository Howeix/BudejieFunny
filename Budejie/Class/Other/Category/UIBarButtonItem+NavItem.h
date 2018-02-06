//
//  UIBarButtonItem+NavItem.h
//  Budejie
//
//  Created by Jerry Huang on 2018/1/14.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIBarButtonItem (NavItem)
+(instancetype)barButtonItemWithImage:(UIImage *)image selImage:(UIImage *)selImage withObjc:(id)objc withSel:(SEL)selector;
+(instancetype)barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage withObjc:(id)objc withSel:(SEL)selector;
+(instancetype)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)objc sel:(SEL)selector title:(NSString *)title;

@end
