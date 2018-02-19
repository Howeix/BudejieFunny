//
//  HWAllViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/28.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWAllViewController.h"
#import "HWTopic.h"
#import "HWTopicCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SDImageCache.h>

@interface HWAllViewController ()

//** headerRefreshing */
@property (assign, nonatomic,getter=isHeaderRefreshing)BOOL headerRefreshing;
//** headerLabel */
@property (weak, nonatomic) UILabel *headerLabel;
//** headerView */
@property (weak, nonatomic) UIView *headerView;
//** topics */
@property (strong, nonatomic) NSMutableArray *topics;

/* 当前最后一条帖子数据的描述信息,专门用来加载下一页数据 */
@property(copy,nonatomic)NSString *maxtime;



@end



static NSString * const HWTopicCellID = @"HWTopicCellID";


@implementation HWAllViewController




- (void)viewDidLoad {

    [super viewDidLoad];
    //设置tableView的顶部内边距 35
    self.tableView.contentInset = UIEdgeInsetsMake(HWTitlesViewH, 0, 0, 0);
    //添加下拉刷新控件
    [self setupHeaderRefresh];
    //添加上拉刷新控件
    [self setupFooterRefresh];
    //添加广告控件为headerView
    [self setupADViewInHeader];
    //取消talbeView每个cell之间的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HWTopicCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:HWTopicCellID];
    self.tableView.allowsSelection = NO;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //进程序就让它发送一次请求
    [self loadNewData];
    
}

-(NSMutableArray *)topics{
    
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}


-(void)setupADViewInHeader{
    UIView *adHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HWScreenW, 35)];
    adHeader.backgroundColor = [UIColor blackColor];
    UILabel *adLabel = [[UILabel alloc] initWithFrame:adHeader.bounds];
    adLabel.textAlignment = NSTextAlignmentCenter;
    adLabel.text = @"广告";
    adLabel.textColor = [UIColor whiteColor];
    [adHeader addSubview:adLabel];
    self.tableView.tableHeaderView = adHeader;
    
}

-(void)setupHeaderRefresh{
    
    //在tableView的顶部添加一个控件,保留tableHeader
    UIView *headerRefreshV = [[UIView alloc] initWithFrame:CGRectMake(0, -50, self.tableView.hw_width, 50)];
    headerRefreshV.backgroundColor = [UIColor redColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:headerRefreshV.bounds];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.text = @"下拉可以刷新";
    headerLabel.textAlignment = NSTextAlignmentCenter;
    _headerLabel = headerLabel;
    _headerView = headerRefreshV;
    [headerRefreshV addSubview:headerLabel];
    [self.tableView addSubview:headerRefreshV];
}


//设置上拉刷新
-(void)setupFooterRefresh{
    //在tableView的顶部添加一个控件,保留tableHeader
//    UIView *footerRefreshV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.hw_width, 50)];
//    footerRefreshV.backgroundColor = [UIColor redColor];
//    UILabel *footerLabel = [[UILabel alloc] initWithFrame:footerRefreshV.bounds];
//    footerLabel.textColor = [UIColor whiteColor];
//    footerLabel.text = @"上拉可以刷新";
//    footerLabel.textAlignment = NSTextAlignmentCenter;
//    [footerRefreshV addSubview:footerLabel];
    //上拉刷新加载更多数据
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


-(void)loadMoreData{
    //接受网络请求
    //创建管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //拼接参数
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"data";
    para[@"type"] = @"1";
    para[@"Maxtime"] = self.maxtime;
    NSLog(@"maxtime - %@",self.maxtime);
    
    [mgr GET:HWCommonURL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
//        HWPlistFileToDesktop(responseObject)
        
        //存储maxtime - 最后一条数据的标识
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *item = responseObject[@"list"];
        
        NSArray *moreTopics = [HWTopic mj_objectArrayWithKeyValuesArray:item];
        
        [self.topics addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        //成功收到数据之后刷新条返回原样
        [UIView animateWithDuration:0.3 animations:^{
            //回归原样
            self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
            _headerView.backgroundColor = [UIColor redColor];
            _headerLabel.text = @"下拉可以刷新";
            self.headerRefreshing = NO;
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}



-(void)loadNewData{
    //接受网络请求
    //创建管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //拼接参数
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"data";
    para[@"type"] = @"1";
//    para[@"Maxtime"] = @"";

        [mgr GET:HWCommonURL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
            
            HWPlistFileToDesktop(responseObject)
            
            NSArray *item = responseObject[@"list"];
            
            NSArray *moreTopics = [HWTopic mj_objectArrayWithKeyValuesArray:item];
            [self.topics addObjectsFromArray:moreTopics];
            
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            //成功收到数据之后刷新条返回原样
            [UIView animateWithDuration:0.3 animations:^{
                //回归原样
                self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
                _headerView.backgroundColor = [UIColor redColor];
                _headerLabel.text = @"下拉可以刷新";
                self.headerRefreshing = NO;
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    
}


#pragma mark - scrollViewDelegate
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    //清除超过屏幕的内容(清除内存缓存)
//    [[SDImageCache sharedImageCache] clearMemory];
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果下拉刷新正在刷新就返回
    
    if(self.tableView.contentOffset.y + 50 > -99){
        //处理当刷新控件顶部位于titleView底部之上的时候
        _headerView.backgroundColor = [UIColor redColor];
        _headerLabel.text = @"下拉可以刷新";
        self.headerRefreshing = NO;
    }
    if (self.headerRefreshing) return;
    //当顶部偏移量小于指定值的时候(titleView的底部位置)
    if (self.tableView.contentOffset.y + 50 < -99) {
        self.headerRefreshing = YES;
        _headerLabel.text = @"正在刷新数据...请稍后";
        _headerView.backgroundColor = [UIColor blueColor];
    }else{
        _headerView.backgroundColor = [UIColor redColor];
        _headerLabel.text = @"下拉可以刷新";
        self.headerRefreshing = NO;
    }

    
}



-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //当下啦然后松开手指之后来到这里
    //1.通过文字判断当前是否在刷新还是正常状态
    //2.通过偏移量判断
    if (self.tableView.contentOffset.y + 50 < -99) {
        //当前处于刷新状态  设置顶部内边距为xx 维持2秒
        self.tableView.contentInset = UIEdgeInsetsMake(85, 0, 0, 0);
        [self loadNewData];
    }
    
}

#pragma mark - TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.topics.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HWTopic *item = self.topics[indexPath.row];
    
    
//    //文字的Y值
//    cellHeight += 55;
//    //文字的高度
//    CGSize maxSize = CGSizeMake(HWScreenW - 2 * 10, MAXFLOAT);
//    cellHeight += [item.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:maxSize].height + 10;
//
//#warning TODO the CELLHEIGHT:
//    if (item.type != HWTopicTypeWord) {
//        /*
//        item.width      maxSize.width
//        ----------- = ----------------
//        item.height     maxSize.height
//                            middleW * item.height
//         maxSize.height = ------------------------
//        */
//        CGFloat middleW = maxSize.width;
//        CGFloat middleH = item.height * middleW / item.width;
//
//        cellHeight += middleH + 10;


//    //如果有最热评论就增加其高度
//    if (item.top_cmt.count) {
//        //最热评论整体的高度
//        //最热评论标签高度 23
//        cellHeight += 33;
//        NSDictionary *cmtDict = item.top_cmt.firstObject;
//        NSString *cmtStr = [NSString stringWithFormat:@"%@: %@",cmtDict[@"user"][@"username"],cmtDict[@"content"]];
//        cellHeight += [cmtStr sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:maxSize].height;
//    }
//
//    //工具条
//    cellHeight += 40;

    
    return item.cellHeight;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:HWTopicCellID];
    
    HWTopic *item = _topics[indexPath.row];
    cell.topic = item;

    
    return cell;
}

@end
