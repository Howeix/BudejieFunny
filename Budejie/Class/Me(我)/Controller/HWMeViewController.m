//
//  HWMeViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWMeViewController.h"
#import "UIBarButtonItem+NavItem.h"
#import "HWSettingViewController.h"
#import "HWCollectionViewCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "HWSquareItem.h"
#import "HWWebViewController.h"

static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const Margin = 1;
#define itemW (HWScreenW - (cols - 1) * Margin) / cols

@interface HWMeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/* selBtn */
//@property(strong,nonatomic)UIButton *selBtn;
/* 模型数组 */
@property(strong,nonatomic)NSMutableArray *items;
/*  */
@property(weak,nonatomic)UICollectionView *collectionV;


@end

@implementation HWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNaviItem];
    [self setupFootView];
    [self loadData];
    
    /*
     跳转细节
     1.collectionView高度重新计算 -> collectionView高度需要根据内容去计算 -> 有数据了 才可以计算
     2.collectionView不需要移动
     3.
     */
    
    //设置cell的间距,默认tableview分组样式,有额外头部和尾部间距
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);

}

-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

-(void)loadData{
    //1请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"square";
    para[@"c"] = @"topic";
    [mgr GET:HWCommonURL parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组
        NSArray *dataArr = responseObject[@"square_list"];
        //字典数组转模型数组
        _items = [HWSquareItem mj_objectArrayWithKeyValuesArray:dataArr];
        
        [self resloveData];
        
        //设置collectionView的高度 计算collectionView高度 = rows * itemH
        
        //万能公式: rows(总行数) = (count - 1) / cols + 1;
        
        //要求的总行数 = (count(数据个数从模型字典中取得) - 1) / cols(总列数) + 1;
        NSInteger count = _items.count;
        NSInteger rows = (count - 1) / cols + 1;
        
        
        //设置collectionView的高度
        self.collectionV.hw_height = rows * itemW;
        
        
        //设置tableView的滚动范围
        self.tableView.tableFooterView = self.collectionV;
        
        //刷新collectionView
        [self.collectionV reloadData];
        
        NSLog(@"%@",NSStringFromCGSize(self.collectionV.contentSize));
        NSLog(@"%@",NSStringFromCGRect(self.tableView.tableFooterView.frame));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


-(void)setupFootView{
    
    /*
     1.初始化要设置流水布局
     2.cell必须要注册
     3.cell必须自定义
     */
    
    //创建布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置cell的尺寸
    //间距
    //总列数
    layout.itemSize = CGSizeMake(itemW, itemW);
    layout.minimumLineSpacing = Margin;
    layout.minimumInteritemSpacing = Margin;
    NSLog(@"%zd",itemW);
    //创建UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    
    self.collectionV = collectionView;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    
    
    collectionView.scrollEnabled = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    NSLog(@"%zd------%zd",self.collectionV.hw_height,self.tableView.tableFooterView.hw_height);
    //注册cell
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:@"HWCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];
    NSLog(@"%zd",self.tableView.tableFooterView.hw_height);


}

- (void)resloveData
{
    // 判断下缺几个
    // 3 % 4 = 3 cols - 3 = 1
    // 5 % 4 = 1 cols - 1 = 3
    NSInteger count = self.items.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i < exter; i++) {
            HWSquareItem *item = [[HWSquareItem alloc] init];
            [self.items addObject:item];
        }
    }
    
}


#pragma collectionViewDataSource

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPatha{
    
    HWSquareItem *item = self.items[indexPatha.row];
    /*
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = [UIScreen mainScreen].bounds;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:item.url]];
    [webView loadRequest:request];
    UIViewController *v = [[UIViewController alloc] init];
    
    [v.view addSubview:webView];
    v.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:v animated:YES];
    */

    //跳转界面 push展示网页
    /*
     1.safari openURL : 自带了很多功能(进度条,toolbar,刷新,前进,倒退...)
     2.UIWebView :  (没功能) , 在当前应用打开网页,并且有Safari,要自己实现, 它不能实现进度条功能
     3.SFSafariViewController
     
     */
    if([item.url containsString:@"mod"])return;
    HWWebViewController *webVC = [[HWWebViewController alloc] init];
    webVC.url = [NSURL URLWithString:item.url];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

#pragma SFSafariViewControllerDelegate
//-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.item = self.items[indexPath.row];
    
    return cell;
}


-(void)setupNaviItem{
    UIBarButtonItem *settingItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] withObjc:self withSel:@selector(setting)];
    UIBarButtonItem *nightItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] withObjc:self withSel:@selector(night:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    self.navigationItem.title = @"我的";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:20]};
}

-(void)night:(UIButton *)btn{
    btn.selected = !btn.selected;
}

-(void)setting{
    HWSettingViewController *setting = [[HWSettingViewController alloc] init];
    setting.view.backgroundColor = [UIColor yellowColor];
    //必须要在跳转之前设置
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}


@end
