//
//  HWADItem.h
//  Budejie
//
//  Created by Jerry Huang on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
// w_picurl,ori_curl:跳转到广告界面,w,h

@interface HWADItem : NSObject
/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;

@property (nonatomic, assign) CGFloat w;

@property (nonatomic, assign) CGFloat h;
@end

