//
//  HWTopicVoiceView.m
//  Budejie
//
//  Created by 黄炜 on 2018/2/9.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWTopicVoiceView.h"
#import "HWTopic.h"
#import "HWSeeBigPictureViewController.h"
#import "HWTopic.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
@interface HWTopicVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@end



@implementation HWTopicVoiceView

+(instancetype)voiceView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
    self.imageView.userInteractionEnabled = YES;
    
}

-(void)seeBigPicture{
    HWSeeBigPictureViewController *vc = [[HWSeeBigPictureViewController alloc] init];
    //    [UIApplication sharedApplication].keyWindow.rootViewController present...
    vc.topic = _topic;
    [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    
}

-(void)setTopic:(HWTopic *)topic{
    
    _topic = topic;

    
    //占位图片
    UIImage *placeholder = nil;
    //根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //获得原图(SDWebImage的图片缓存是用图片的url字符串作为key)
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image1];
    if (originImage) { //原图已经被下载过
        self.imageView.image = originImage;
    }else{  //原图并未下载过
        if (mgr.isReachableViaWiFi) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
        }else if (mgr.isReachableViaWWAN){
            BOOL downloadOriginImageWhen3Gor4G = YES;
            if (downloadOriginImageWhen3Gor4G) {
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:placeholder];
            }else{
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image0] placeholderImage:placeholder];
            }
        }else{    //没有可用网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topic.image0];
            if (thumbnailImage) { //缩略图已经被下载过
                self.imageView.image = thumbnailImage;
            }else{ //没有下载过任何图片
                //占位图片;
                self.imageView.image = placeholder;
            }
        }
    }
    
    /*
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_topic.image1]];
    */
    //播放数量
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放",topic.playcount / 10000.0];
    }else{
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    }
    // %04d :占据4位,多余的空位用0填补
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topic.voicetime / 60, topic.voicetime % 60];
    
    
}


@end
