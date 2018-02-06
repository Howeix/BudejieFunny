//
//  HWSubTagCell.m
//  Budejie
//
//  Created by 黄炜 on 2018/1/15.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWSubTagCell.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Image.h"

@interface HWSubTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;



@end

@implementation HWSubTagCell


-(void)setItem:(HWSubTagItem *)item{
    _item = item;
    
    self.nameView.text = _item.theme_name;
    NSString *str = item.sub_number;
    NSInteger num = str.integerValue;
    if (num >= 10000) {
        CGFloat numNew = num / 10000.0;
        self.numView.text = [NSString stringWithFormat:@"%0.1f万人订阅",numNew];
        self.numView.text = [self.numView.text stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else{
    self.numView.text = [NSString stringWithFormat:@"%@人订阅",str];
    }
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}

//从xib加载就会调用,只会调用一次
-(void)awakeFromNib{
    [super awakeFromNib];
    //设置头像圆角
    _iconView.layer.cornerRadius = 30;
    _iconView.layer.masksToBounds = YES;
    
    
}

@end
