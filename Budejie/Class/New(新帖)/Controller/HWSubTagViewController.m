//
//  HWSubTagViewController.m
//  Budejie
//
//  Created by 黄炜 on 2018/1/15.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWSubTagViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "HWSubTagItem.h"
#import "HWSubTagCell.h"


@interface HWSubTagViewController ()
//** 模型数组 */
@property (strong, nonatomic) NSArray *subTags;
@end

static NSString *ID = @"subTagCell";

@implementation HWSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HWSubTagCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ID];
    [self loadData];
    
    self.title = @"推荐标签";
    
    
    

}


-(void)loadData{
    //获取数据
    
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        _subTags = [HWSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        
        //刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _subTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //自定义cell
    HWSubTagCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
    
    
    HWSubTagItem *item = self.subTags[indexPath.row];
    cell.item = item;
    
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}


@end
