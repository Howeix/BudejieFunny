//
//  HWConst.m
//  Budejie
//
//  Created by 黄炜 on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import <UIKit/UIKit.h>


/** UITabBar的高度 */
CGFloat const HWTabBarH = 49;

/** 导航栏的最大Y值 */
CGFloat const HWNavMaxY = 64;

/** 标题栏的高度 */
CGFloat const HWTitlesViewH = 35;

/** 全局统一的间距 */
CGFloat const HWMarin = 10;


/** 统一的一个请求路径 */
NSString * const HWCommonURL = @"http://api.budejie.com/api/api_open.php";


/** tabBarButton重复被点击发出的通知 */
NSString * const HWTabBarButtonDidRepeatClickNotification = @"HWTabBarButtonDidRepeatClickNotification";

/** TitleButton被重复点击的通知 */
NSString * const HWTitleButtonDidRepeatClickNotification = @"HWTitleButtonDidRepeatClickNotification";
