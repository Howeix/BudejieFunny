//
//  HWLoginRegisterView.m
//  Budejie
//
//  Created by Jerry Huang on 2018/1/21.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWLoginRegisterView.h"

@implementation HWLoginRegisterView

+(instancetype)loginView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

+(instancetype)registerView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


@end
