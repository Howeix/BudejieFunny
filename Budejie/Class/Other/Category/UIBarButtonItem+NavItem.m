//
//  UIBarButtonItem+NavItem.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/14.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "UIBarButtonItem+NavItem.h"
#import "UIView+Frame.h"
@implementation UIBarButtonItem (NavItem)
+(instancetype)barButtonItemWithImage:(UIImage *)image highlightImage:(UIImage *)highlightImage withObjc:(id)objc withSel:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highlightImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:objc action:selector forControlEvents:UIControlEventTouchUpInside];
    UIView *v = [[UIView alloc] initWithFrame:btn.bounds];
    [v addSubview:btn];
    return [[self alloc] initWithCustomView:v];
}

+(instancetype)barButtonItemWithImage:(UIImage *)image selImage:(UIImage *)selImage withObjc:(id)objc withSel:(SEL)selector{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:objc action:selector forControlEvents:UIControlEventTouchUpInside];
    UIView *v = [[UIView alloc] initWithFrame:btn.bounds];
    [v addSubview:btn];
    return [[self alloc] initWithCustomView:v];
}


+(instancetype)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)objc sel:(SEL)selector title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btn addTarget:objc action:selector forControlEvents:UIControlEventTouchUpInside];
//    UIView *v = [[UIView alloc] initWithFrame:btn.bounds];
//    [v addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
