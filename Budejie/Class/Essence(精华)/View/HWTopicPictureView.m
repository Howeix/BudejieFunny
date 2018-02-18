//
//  HWTopicPictureView.m
//  Budejie
//
//  Created by 黄炜 on 2018/2/9.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import <UIImage+GIF.h>
#import "HWTopic.h"

@interface HWTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gif;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end



@implementation HWTopicPictureView



+(instancetype)pictureView{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];

}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

-(void)setTopic:(HWTopic *)topic{
    
    _topic = topic;
    
    self.gif.hidden = ![_topic.image1.pathExtension.lowercaseString isEqualToString:@"gif"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_topic.image1]];
//    if ([_topic.image1.pathExtension.lowercaseString isEqualToString:@"gif"]) {
//        self.gif.hidden = NO;
//
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_topic.image1]];
//
//    }else{
//        self.gif.hidden = YES;
//    }
//    self.seeBigPictureButton.hidden =
//    _topic.cellHeight;
    //点击查看大图
    if (_topic.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else{
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = YES;
    }
    
}


@end
