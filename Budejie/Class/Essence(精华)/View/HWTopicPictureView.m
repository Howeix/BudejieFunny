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
    _topic.cellHeight;
//    if ([_topic.image1.pathExtension.lowercaseString isEqualToString:@"gif"]) {
//        self.gif.hidden = NO;
//
//        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_topic.image1]];
//
//    }else{
//        self.gif.hidden = YES;
//    }
//    self.seeBigPictureButton.hidden =
    
    //点击查看大图
    if (_topic.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
        //处理超长图片
        if (self.imageView.image) {
            CGFloat imageW = topic.middleFrame.size.width;
            CGFloat imageH = imageW * topic.height /topic.width;
            //开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            //绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            //关闭上下文
            UIGraphicsEndPDFContext();
        }
        
    }else{
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = YES;
    }
    
}


@end
