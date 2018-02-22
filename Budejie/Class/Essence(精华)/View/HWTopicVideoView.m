//
//  HWTopicVideoView.m
//  Budejie
//
//  Created by 黄炜 on 2018/2/9.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWTopicVideoView.h"
#import "HWTopic.h"
#import "HWSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>
//#import <AFNetworking.h>
@interface HWTopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;


@end


@implementation HWTopicVideoView

+(instancetype)videoView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

-(void)setTopic:(HWTopic *)topic{
    _topic = topic;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_topic.image1]];
    
    //播放数量
    if (topic.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放",topic.playcount / 10000.0];
    }else{
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    }
    // %04d :占据4位,多余的空位用0填补
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",topic.videotime / 60, topic.videotime % 60];
    
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

@end
