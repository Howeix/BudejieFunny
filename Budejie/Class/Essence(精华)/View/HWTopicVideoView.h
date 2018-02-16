//
//  HWTopicVideoView.h
//  Budejie
//
//  Created by 黄炜 on 2018/2/9.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWTopic;
@interface HWTopicVideoView : UIView
/* 模型 */
@property(strong,nonatomic)HWTopic *topic;
+(instancetype)videoView;
@end
