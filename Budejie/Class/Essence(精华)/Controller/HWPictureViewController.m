//
//  HWPictureViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/28.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWPictureViewController.h"

@interface HWPictureViewController ()

@end

@implementation HWPictureViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = HWRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(HWTitlesViewH, 0, 0, 0);
    NSLog(@"%s",__func__);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

static NSString * const ID = @"cell";

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是图片cell的第%zd行",indexPath.row];
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

@end
