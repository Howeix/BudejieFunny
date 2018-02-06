//
//  HWSettingViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/14.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWSettingViewController.h"
#import <SDImageCache.h>

@interface HWSettingViewController ()

@end


@implementation HWSettingViewController

static NSString * const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:0 target:self action:@selector(jump)];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
}

-(void)jump{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    [self getFileSize];
    NSLog(@"%ld",size);
    cell.textLabel.text = @"清楚缓存";
    
    return cell;
}


-(void)getFileSize{
    
    
}

@end
