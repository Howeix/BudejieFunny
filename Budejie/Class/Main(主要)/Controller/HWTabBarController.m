//
//  HWTabBarController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWTabBarController.h"
#import "HWEssenceViewController.h"
#import "HWFriendTrendViewController.h"
#import "HWMeViewController.h"
#import "HWNewViewController.h"
#import "HWPublishViewController.h"
#import "HWNavigationViewController.h"
#import "HWTabBar.h"
#import "UIImage+Image.h"



@interface HWTabBarController ()

@end

@implementation HWTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加自控制器(5个自控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    //2.设置tabBar上按钮内容 ->由对应的自控制器的tabBarItem属性
    [self setupAllTitleButton];
    
    //3.自定义tabBar
    [self setupTabBar];
}


+(void)load{
    //获取那个类中的UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
    NSLog(@"%s",__func__);
}

/**
+(void)initialize{
    if (self == [self class]) {
        //获取那个类中的UITabBarItem
        UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
        
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
        [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
        
        NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
        attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
        
        NSLog(@"%s",__func__);
    }
}
*/


-(void)setupTabBar{
    
    HWTabBar *tabBarC = [[HWTabBar alloc] init];
    [self setValue:tabBarC forKey:@"tabBar"];
    
    
    
}



-(void)setupAllChildViewController{
    
    HWEssenceViewController *essenceVC = [[HWEssenceViewController alloc] init];
    HWNavigationViewController *nav = [[HWNavigationViewController alloc] initWithRootViewController:essenceVC];
    [self addChildViewController:nav];
    
    HWNewViewController *newVC = [[HWNewViewController alloc] init];
    HWNavigationViewController *nav1 = [[HWNavigationViewController alloc] initWithRootViewController:newVC];
    [self addChildViewController:nav1];
    
    HWFriendTrendViewController *ftVC = [[HWFriendTrendViewController alloc] init];
    HWNavigationViewController *nav2 = [[HWNavigationViewController alloc] initWithRootViewController:ftVC];
    [self addChildViewController:nav2];
    
    
#warning 通过Storyboard加载控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([HWMeViewController class]) bundle:nil];
    
    //加载storyboard中箭头指向的控制器
    HWMeViewController *meVC = [storyboard instantiateInitialViewController];
    HWNavigationViewController *nav3 = [[HWNavigationViewController alloc] initWithRootViewController:meVC];
    [self addChildViewController:nav3];
    
    
    
}

-(void)setupAllTitleButton{
    
    // 0:精华
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    // 1:新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    // 3.关注
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    // 4.我
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
    
    
    
}

//-(void)setupTabBar{
//    
//    
//}




@end
