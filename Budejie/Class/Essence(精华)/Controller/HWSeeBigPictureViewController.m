//
//  HWSeeBigPictureViewController.m
//  Budejie
//
//  Created by Jerry Huang on 2018/2/22.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWSeeBigPictureViewController.h"
#import "HWTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

@interface HWSeeBigPictureViewController ()<UIScrollViewDelegate>
/* scrollView */
@property(weak,nonatomic)UIScrollView *scrollView;
/* imageView */
@property(weak,nonatomic)UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;



@end

@implementation HWSeeBigPictureViewController

//-(PHAssetCollectionChangeRequest *)phassetCollectionChangeRequest{
//    if (!_phassetCollectionChangeRequest) {
//        NSError *error = nil;
//        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
//
//            NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
//            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
//
//        } error:&error];
//    }
//    return _phassetCollectionChangeRequest;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.scrollView.backgroundColor = [UIColor grayColor];
//    NSLog(@"%@",NSStringFromCGSize(self.scrollView.contentSize));
////    NSLog(@"%@",self.scrollView);
//    self.imageView.backgroundColor = [UIColor clearColor];
    
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
//    scrollView.backgroundColor = [UIColor redColor];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    
    
    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back:)]];
    
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!imageView) return;
        self.saveButton.enabled = YES;
    }];
    imageView.hw_width = scrollView.hw_width;
    imageView.hw_height = imageView.hw_width * self.topic.height / self.topic.width;
    imageView.hw_x = 0;
    if (imageView.hw_height > HWScreenH) {   //超过一个屏幕
        imageView.hw_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.hw_height);
    }else{
        imageView.hw_centerY = scrollView.hw_height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    //图片缩放    返回的图片宽度大于图片控件的尺寸
    CGFloat maxScale = self.topic.width / imageView.hw_width;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
}

#pragma mark - <UIScrollViewDelegate>
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
}


//-(UIScrollView *)scrollView{
//    if (!_scrollView) {
//        UIScrollView *scrollView = [[UIScrollView alloc] init];
//        _scrollView = scrollView;
//        _scrollView.frame = [UIScreen mainScreen].bounds;
//
//        CGFloat pictureW = _topic.width;
//        CGFloat pictureH = _scrollView.hw_width * self.topic.height / self.topic.width;
//        CGFloat pictureX = 0;
//        if (_scrollView.hw_height > HWScreenH) {
//            _scrollView.hw_y = 0;
//        }else{
//            _
//        }
//        _scrollView.contentSize = CGSizeMake(pictureW, pictureH);
//        [self.view insertSubview:_scrollView atIndex:0];
//    }
//    return _scrollView;
//}
//
//
//-(UIImageView *)imageView{
//    if (!_imageView) {
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.frame = CGRectMake(0, 0, self.scrollView.hw_width, self.scrollView.hw_height);
//        [imageView sd_setImageWithURL:[NSURL URLWithString:_topic.image1]];
//        [_scrollView addSubview:imageView];
//    }
//    return _imageView;
//}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)save:(UIButton *)sender {
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    /*
    photos框架
    
    1.PHAsset : 一个PHAsset对象就代表相册中的一张图片或者一个视频
     1>查 : [PHAsset fetchAssets...]
     2>增删改 : PHAssetChangeRequest(包括所有跟图片和视频相关的改动操作)
     
     2.PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     1>查 : [PHAssetCollection fetchAssets...]
     2>增删改 : PHAssetCollectionChangeRequest(包括所有相册相关的改动操作)
     
     3.对相片或相册任何增删改操作,都必须放到一下方法的block中执行
     [PHPhotoLibrary sharedPhotoLibrary] performChanges
     [PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait
    */
    
    
    //异步执行修改操作
    /*
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"保存失败!"];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
        }
    }];
    */
    
    
    //同步执行修改操作
    NSError *error = nil;
//    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
//        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
//    } error:&error];
//
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
//    }else{
//        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
//    }
    
    
    //获得app名字
    NSString *appName = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    
    //拥有一个[自定义相册]
    
    //先判断相册中有没有同名的相册:  如果有就返回 没有就创建
    PHFetchResult<PHAssetCollection *> * fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHAssetCollection *createdCollection = nil;
    for (PHAssetCollection *collection in fetchResult) {
        NSLog(@"%@",collection.localizedTitle);
        if ([collection.localizedTitle isEqualToString:appName]){
            createdCollection = collection;
            break;
        }
    }
    //当前App对应的自定义相册没有被创建过
    if (createdCollection == nil) {
        NSError *error = nil;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:appName];
        } error:&error];
    }
    
    
    
}

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
//    }else{
//        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//    }
//}
//保存图片到[相机胶卷]
//c语言函数
//AssetsLibrary.framework
//Photos框架


//拥有一个[自定义相册]
//AssetsLibrary.framework
//Photos框架


//添加刚才保存的图片到[自定义相册]
//AssetsLibrary.framework
//Photos框架



@end
