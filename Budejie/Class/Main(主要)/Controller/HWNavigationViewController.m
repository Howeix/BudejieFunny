//
//  HWNavigationViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWNavigationViewController.h"
#import "UIBarButtonItem+NavItem.h"

@interface HWNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation HWNavigationViewController

+(void)initialize{
    
    
    //统一设置NavBar的属性
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:100];
    [navBar setTitleTextAttributes:attrs];
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航控制器的Title
    [navBar setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:20]
                                     }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    
    pan.delegate = self;
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
    static int i = 0;
    i++;
    NSLog(@"%d",i);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}

//拦截这个方法,给导航栏添加LeftBarButton
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
#warning must to be: self.childViewController.count > 0
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self sel:@selector(popViewControllerAnimated:)title:@"返回"];
    }
    
    [super pushViewController:viewController animated:animated];
    
    
}


@end
