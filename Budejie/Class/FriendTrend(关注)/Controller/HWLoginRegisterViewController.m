//
//  HWLoginRegisterViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/21.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWLoginRegisterViewController.h"

@interface HWLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingCons;

@end

@implementation HWLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HWLoginRegisterView *loginV = [HWLoginRegisterView loginView];
    
    [self.middleView addSubview:loginV];
    
    HWLoginRegisterView *registerView = [HWLoginRegisterView registerView];
    
    [self.middleView addSubview:registerView];
    
    
}


-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    HWLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.hw_width * 0.5, self.middleView.hw_height);
    
    HWLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.hw_width * 0.5, 0, self.middleView.hw_width * 0.5, self.middleView.hw_height);
    
    
}


- (IBAction)registerBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    _leadingCons.constant = _leadingCons.constant == 0 ? -self.middleView.hw_width * 0.5 : 0;
    
    NSLog(@"%@",NSStringFromCGRect(self.middleView.frame));
    [UIView animateWithDuration:1 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    
}



- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
