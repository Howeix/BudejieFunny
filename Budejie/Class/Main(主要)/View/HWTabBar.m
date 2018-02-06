//
//  HWTabBar.m
//  Budejie
//
//  Created by 黄炜 on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWTabBar.h"

@interface HWTabBar()
@property (weak, nonatomic) UIButton *plusButton;
@property (weak, nonatomic) UIControl *previousClickedTabBarButton;
@end


@implementation HWTabBar

-(UIButton *)plusButton{
    if (!_plusButton) {
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        
        [self addSubview:btn];
        _plusButton = btn;
    }
    return _plusButton;

}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //跳转tabBarButton位置
    NSInteger count = self.items.count;
    
    CGFloat btnW = self.hw_width / (count + 1);
    CGFloat btnH = self.hw_height;
    CGFloat x = 0;
    int i = 0;
    //私有类:打印出来有这个类,但是敲不出来,说明这是系统私有类
    //遍历子控件,调整布局
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //设置previousClickedTabBarButton默认值为最前面的按钮
            if (i == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarButton;
            }
            if (i == 2) {
                i += 1;
            }
            x = i * btnW;
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            i++;
            //监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    self.plusButton.center = CGPointMake(self.hw_width * 0.5, self.hw_height * 0.5);
}


-(void)tabBarButtonClick:(UIControl *)tabBarButton{
    if (self.previousClickedTabBarButton == tabBarButton) {
        //发出通知,告知外界tabBarButton被重复点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:HWTabBarButtonDidRepeatClickNotification object:nil];
        NSLog(@"%s",__func__);
    }
    self.previousClickedTabBarButton = tabBarButton;
}


@end
