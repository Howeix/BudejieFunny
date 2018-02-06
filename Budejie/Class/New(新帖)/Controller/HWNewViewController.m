//
//  HWNewViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWNewViewController.h"
#import "UIBarButtonItem+NavItem.h"
#import "HWSubTagViewController.h"
@interface HWNewViewController ()

@end

@implementation HWNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    
    self.view.backgroundColor = HWRandomColor;
    
    
    
}

-(void)setupNavi{
    
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"MainTagSubIconClick"] highlightImage:[UIImage imageNamed:@"MainTagSubIcon"] withObjc:self withSel:@selector(tagClick)];
    
    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationItem.title = @"新帖";

}


-(void)tagClick{
    //创建HWSubTag控制器,拿到导航控制器,把HWSubTag控制器push到栈顶 .\
    HWSubTag具体的内容由他自己去设置和管理
    HWSubTagViewController *subTagVC = [[HWSubTagViewController alloc] init];
    [self.navigationController pushViewController:subTagVC animated:YES];
    
}

@end
