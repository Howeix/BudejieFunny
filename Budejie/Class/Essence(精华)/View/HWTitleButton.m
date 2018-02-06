//
//  HWTitleButton.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/28.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWTitleButton.h"

@implementation HWTitleButton

-(void)setHighlighted:(BOOL)highlighted{}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.backgroundColor = [HWColor(25, 25, 25) colorWithAlphaComponent:0.4];
    }
    return self;
}

//-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
//    
//    [self addTarget:target action:action forControlEvents:controlEvents];
//}


@end
