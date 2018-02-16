//
//  HWVideoViewController.h
//  Budejie
//
//  Created by Jerry Huang on 2018/1/28.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWTopic;
@interface HWVideoViewController : UITableViewController
/* 模型 */
@property(strong,nonatomic)HWTopic *topic;
/* 模型数组 */
@property(strong,nonatomic)NSMutableArray <HWTopic *>*topics;

@end
