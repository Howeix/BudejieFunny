//
//  HWEssenceViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWEssenceViewController.h"
#import "UIBarButtonItem+NavItem.h"
#import "HWTitleButton.h"
#import "HWAllViewController.h"
#import "HWPictureViewController.h"
#import "HWVideoViewController.h"
#import "HWVoiceViewController.h"
#import "HWWordViewController.h"

@interface HWEssenceViewController ()<UIScrollViewDelegate>
/* titleView */
@property(weak,nonatomic)UIView *titleView;
/* previousTitleButton */
@property(weak,nonatomic)UIButton *previousTitleButton;
/* line */
@property(weak,nonatomic)UIView *titleLine;
/* scrollView */
@property(weak,nonatomic)UIScrollView *scrollView;

@end

@implementation HWEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化自控制器
    [self setupAllChildVCs];
    
    
    [self setupNavigationBar];
  
    
    //scrollView
    [self setupScrollView];
    
    //Title
    [self setupTitle];
    
    //创建第0个自控制器的view添加到scrollview
    [self addViewIntoScrollView:0];
    
    
}


-(void)setupAllChildVCs{
    
    [self addChildViewController:[HWAllViewController new]];
    [self addChildViewController:[HWPictureViewController new]];
    [self addChildViewController:[HWVideoViewController new]];
    [self addChildViewController:[HWVoiceViewController new]];
    [self addChildViewController:[HWWordViewController new]];
    
}

#pragma mark - setupScrollView
-(void)setupScrollView{
    
    //不允许自动修改scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
    scrollView.showsHorizontalScrollIndicator = NO;

    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    
//    NSInteger count = self.childViewControllers.count;
    
    //将自对应索引控制器的view添加到scrollView中
//    for (int i = 0; i < count ; i++) {
//        //取出i位置自控制器的view
//        UIView *childView = self.childViewControllers[i].view;
//        childView.hw_x = i * scrollView.hw_width;
//        [scrollView addSubview:childView];
//    }
    
    scrollView.contentSize = CGSizeMake(HWScreenW * 5, 0);
    
}


-(void)setupTitle{
    
    
    UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), HWScreenW, HWTitlesViewH)];
    titleV.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    [self.view addSubview:titleV];
    self.titleView = titleV;
    
    //设置标题按钮
    [self setupTitleButton];
    //设置下划线
    [self underLine];
    
}

-(void)setupTitleButton{
    
    CGFloat btnW = HWScreenW / 5;
    
    NSArray *title = @[@"全部",@"图片",@"视频",@"声音",@"段子"];
    
    
    for (int i = 0; i < 5; i++) {
        HWTitleButton *btn = [HWTitleButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title[i] forState:UIControlStateNormal];

        btn.frame = CGRectMake(btnW * i, 0, btnW, HWTitlesViewH);
//        btn.backgroundColor = HWRandomColor;
        btn.tag = i;
        [self.titleView addSubview:btn];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


-(void)underLine{
    
    //创建一个UIVIew
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.hw_height, self.titleView.hw_width / 5 , 0.7)];
    lineV.backgroundColor = [UIColor redColor];
    [_titleView addSubview:lineV];
    self.titleLine = lineV;
    
    //设置一开始就选中"全部"按钮  并且设置underline
//    [self titleBtnClick:self.titleView.subviews[0]];
    HWTitleButton *firstButton = self.titleView.subviews.firstObject;
    firstButton.selected = YES;
    self.previousTitleButton = firstButton;
    
    //设置titleUnderLine的宽度 和按钮中字体宽度一致 然后+10;
    self.titleLine.hw_width = [firstButton.currentTitle sizeWithAttributes:@{NSFontAttributeName : firstButton.titleLabel.font}].width + 10;
    [firstButton.currentTitle sizeWithAttributes:@{NSFontAttributeName : firstButton.titleLabel.font}];
    _titleLine.hw_centerX = firstButton.hw_centerX;
}

#pragma mark - 监听titleBtn点击
-(void)titleBtnClick:(HWTitleButton *)titleButton{
    
    self.previousTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousTitleButton = titleButton;
    //切换指定索引的view scrollViewX为scrollView x的偏移值
    CGFloat scrollViewX = titleButton.tag * HWScreenW;
    //点击按钮时要移动line
    [UIView animateWithDuration:0.5 animations:^{
        //根据文字宽度改变line的宽度
//        self.titleLine.hw_width = [titleButton.currentTitle sizeWithFont:titleButton.titleLabel.font].width + 10;
        //获取字体长度
        self.titleLine.hw_width = [titleButton.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleButton.titleLabel.font}].width + 10;
        [titleButton.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleButton.titleLabel.font}];
        _titleLine.hw_centerX = titleButton.hw_centerX;
        self.scrollView.contentOffset = CGPointMake(scrollViewX, self.scrollView.contentOffset.y);
    }completion:^(BOOL finished) {
        [self addViewIntoScrollView:titleButton.tag];
    }];
    
    
    
    
    
}


#pragma mark - 抽取获得索引子控制器view的方法
-(void)addViewIntoScrollView:(NSInteger)index{
    //当点击按钮完成后来到这里创建对应索引控制器的view 并添加到scrollView当中
//    NSInteger index = titleButton.tag;
    UIViewController *currentVC = self.childViewControllers[index];
    //判断是否已经有加载过了
    if (currentVC.isViewLoaded) return;
    
    
    currentVC.view.frame = CGRectMake(index * _scrollView.hw_width, 0, _scrollView.hw_width, _scrollView.hw_height);
    [_scrollView addSubview:currentVC.view];
    
}



-(void)setupNavigationBar{
    UIBarButtonItem *leftItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"nav_item_game_click_icon"] highlightImage:[UIImage imageNamed:@"nav_item_game_click_iconN"] withObjc:self withSel:@selector(game)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationButtonRandomClick"] highlightImage:[UIImage imageNamed:@"navigationButtonRandom"] withObjc:self withSel:@selector(random)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [imageV sizeToFit];
    self.navigationItem.titleView = imageV;
}

-(void)game{
    UITableViewController *vc = [[UITableViewController alloc] init];
    vc.view.backgroundColor = [UIColor grayColor];
    [self random];
    [self presentViewController:vc animated:YES completion:nil];
    
}


/**
 点击Random按钮触发
 */
-(void)random{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - scrollView拖拽结束之后调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //停止拖拽之后获得当前tableView所在的索引
    NSInteger index = scrollView.contentOffset.x / HWScreenW;
//    HWTitleButton *titleButton = [self.titleView viewWithTag:index];
    [self titleBtnClick:_titleView.subviews[index]];
    
}

@end
