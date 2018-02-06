//
//  HWConst.h
//  Budejie
//
//  Created by 黄炜 on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface HWConst : NSObject

/** UITabBar高度 */
UIKIT_EXTERN CGFloat const HWTabBarH;

/** 导航栏的最大Y值 */
UIKIT_EXTERN CGFloat const HWNavMaxY;

/** 标题栏的高度 */
UIKIT_EXTERN CGFloat const HWTitlesViewH;

/** 全局统一的间距 */
UIKIT_EXTERN CGFloat const HWMargin;

/** 统一的一个请求路径 */
UIKIT_EXTERN NSString * const HWCommonURL;

/** TabBarButton被重复点击的通知 */
UIKIT_EXTERN NSString * const HWTabBarButtonDidRepeatClickNotification;

/** TitleButton被重复点击的通知 */
UIKIT_EXTERN NSString * const HWTitleButtonDidRepeatClickNotification;


@end
