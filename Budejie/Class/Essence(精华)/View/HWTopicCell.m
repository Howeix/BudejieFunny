//
//  HWTopicCell.m
//  Budejie
//
//  Created by Jerry Huang on 2018/2/4.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWTopicCell.h"
#import "HWTopic.h"
#import "UIImage+Image.h"
#import <UIImageView+WebCache.h>
#import "HWTopicVideoView.h"
#import "HWTopicPictureView.h"
#import "HWTopicVoiceView.h"

@interface HWTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIView *top_cmtView;
@property (weak, nonatomic) IBOutlet UILabel *top_cmtContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/* videoView */
@property(weak,nonatomic)HWTopicVideoView *topicVideoView;
/* pictureView */
@property(weak,nonatomic)HWTopicPictureView *topicPictureView;
/* voiceView */
@property(weak,nonatomic)HWTopicVoiceView *topicVoiceView;

@end

@implementation HWTopicCell

-(HWTopicVideoView *)topicVideoView{
    if (!_topicVideoView) {
        _topicVideoView = [HWTopicVideoView videoView];
        [self addSubview:_topicVideoView];
    }
    return _topicVideoView;
}
-(HWTopicPictureView *)topicPictureView{
    if (!_topicPictureView) {
        _topicPictureView = [HWTopicPictureView pictureView];
        [self addSubview:_topicPictureView];
    }
    return _topicPictureView;
}
-(HWTopicVoiceView *)topicVoiceView{
    if (!_topicVoiceView) {
        _topicVoiceView = [HWTopicVoiceView voiceView];
        [self addSubview:_topicVoiceView];
    }
    return _topicVoiceView;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

-(void)setTopic:(HWTopic *)topic{
    _topic = topic;
    
    if (_topic.top_cmt.count) {
        self.top_cmtView.hidden = NO;
        
        NSDictionary *cmtDict = _topic.top_cmt.firstObject;
        
        //给最热评论内容传数据
        self.top_cmtContentLabel.text = [NSString stringWithFormat:@"%@: %@",cmtDict[@"user"][@"username"],cmtDict[@"content"]];
        
    }else{
        self.top_cmtView.hidden = YES;
    }
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:_topic.profile_image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        //1.开启图形上下文
//        //比例因素:当前点与像素比例
//        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
//        //2.描述裁剪区域
//        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
//        //3.设置裁剪区域
//        [path addClip];
//        //4.画图片
//        [image drawAtPoint:CGPointZero];
//        //5.取出图片
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        //6.关闭上下文
//        UIGraphicsEndPDFContext();
        self.profileImageView.image = [image hw_circleImage];
    }];

    self.nameLabel.text = _topic.name;
    self.passtimeLabel.text = _topic.passtime;
    self.text_label.text = _topic.text;
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
//    中间的内容
//    if (topic.type == HWTopicTypePicture) {
//        [self.contentView addSubview:self.topicPictureView];
//
//    }else if (topic.type == HWTopicTypeVideo){
//        [self.contentView addSubview:self.topicVideoView];
//    }else if (topic.type == HWTopicTypeVoice){
//        [self.contentView addSubview:self.topicVoiceView];
//        self.topicVoiceView.topic = topic;
//    }
    
    //判断当前模型的类型显示指定的内容,以防循环利用
    if (topic.type == HWTopicTypePicture) { //图片
        self.topicPictureView.hidden = NO;
        self.topicVoiceView.hidden = YES;
        self.topicVideoView.hidden = YES;
        self.topicPictureView.topic = topic;
    }else if (topic.type == HWTopicTypeVideo){ //视频
        self.topicPictureView.hidden = YES;
        self.topicVoiceView.hidden = YES;
        self.topicVideoView.hidden = NO;
        self.topicVideoView.topic = topic;
    }else if (topic.type == HWTopicTypeVoice){ //声音
        self.topicPictureView.hidden = YES;
        self.topicVoiceView.hidden = NO;
        self.topicVoiceView.topic = topic;
        self.topicVideoView.hidden = YES;
    }else if (topic.type == HWTopicTypeWord){ //段子
        self.topicPictureView.hidden = YES;
        self.topicVoiceView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }
}

-(void)layoutSubviews{
    if (self.topic.type == HWTopicTypePicture) { //图片
        self.topicPictureView.frame = self.topic.middleFrame;
    }else if (self.topic.type == HWTopicTypeVideo){ //视频
        self.topicVideoView.frame = self.topic.middleFrame;
    }else if (self.topic.type == HWTopicTypeVoice){ //声音
        self.topicVoiceView.frame = self.topic.middleFrame;
    }
//  NSLog(@"%@",class_getSuperclass());
}


- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder{
    if (number >= 10000) {
        NSString *str = [NSString stringWithFormat:@"%0.1f万",number / 10000.0];
        [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [button setTitle:str forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}


/*
-(void)setupButtonTitle:(UIButton *)button number:(NSInteger)number{
    //处理定数量超过1万
    if (number >= 10000) {
        CGFloat topicDingNum = number / 10000.0;
        NSString *topicDing = [NSString stringWithFormat:@"%0.2f万",topicDingNum];
        [self.dingButton setTitle:topicDing forState:UIControlStateNormal];
    }else if(dingNum > 0){
        
        [self.dingButton setTitle:[NSString stringWithFormat:@"%zd",topic.ding] forState:UIControlStateNormal];
    }else{
        [self.dingButton setTitle:@"顶" forState:UIControlStateNormal];
    }
    [self.caiButton setTitle:[NSString stringWithFormat:@"%zd",topic.cai] forState:UIControlStateNormal];
    
    
}
*/

@end
