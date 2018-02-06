//
//  HWFriendTrendViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWFriendTrendViewController.h"
#import "UIBarButtonItem+NavItem.h"
#import "HWLoginRegisterViewController.h"


@interface HWFriendTrendViewController ()

@end

@implementation HWFriendTrendViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self setupNaviItem];
    
    
    
    
    
}

-(void)setupNaviItem{
    UIBarButtonItem *item = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] highlightImage:[UIImage imageNamed:@"friendsRecommentIcon"] withObjc:self withSel:@selector(friendsRecomment)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.navigationItem.title = @"关注";
    
}

- (IBAction)clickLoginRegisterButton:(UIButton *)sender {
    HWLoginRegisterViewController *loginRegisterVC = [[HWLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVC animated:YES completion:nil];
    
}

-(void)friendsRecomment{
    
    
}

@end
