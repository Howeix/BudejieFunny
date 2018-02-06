//
//  HWCollectionViewCell.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/21.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWCollectionViewCell.h"
#import "HWSquareItem.h"
#import <UIImageView+WebCache.h>

@interface HWCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *labelView;

@end

@implementation HWCollectionViewCell


-(void)setItem:(HWSquareItem *)item{
    _item = item;
    self.labelView.text = item.name;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
