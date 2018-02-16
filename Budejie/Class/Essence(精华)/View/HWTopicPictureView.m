//
//  HWTopicPictureView.m
//  Budejie
//
//  Created by 黄炜 on 2018/2/9.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "HWTopic.h"

@interface HWTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

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
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_topic.image1]];
    
    
}


@end
