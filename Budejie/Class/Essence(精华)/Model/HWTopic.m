//
//  HWTopic.m
//  Budejie
//
//  Created by 黄炜 on 2018/1/31.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWTopic.h"

@implementation HWTopic

//-(CGFloat)cellHeight{
//    if (_cellHeight)return _cellHeight;
//    //文字的Y值
//    _cellHeight += 55;
//    //文字的高度
//    CGSize maxSize = CGSizeMake(HWScreenW - 2 * 10, MAXFLOAT);
//    _cellHeight += [self.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:maxSize].height + 10;
//
//#warning TODO the CELLHEIGHT:
//    if (self.type != HWTopicTypeWord) {
//        /*
//         item.width      maxSize.width
//         ----------- = ----------------
//         item.height     maxSize.height
//         middleW * item.height
//         maxSize.height = ------------------------
//         */
//        CGFloat middleW = maxSize.width;
//        CGFloat middleH = self.height * middleW / self.width;
//
//        _cellHeight += middleH + 10;
//    }
//
//    //如果有最热评论就增加其高度
//    if (self.top_cmt.count) {
//        //最热评论整体的高度
//        //最热评论标签高度 23
//        _cellHeight += 33;
//        NSDictionary *cmtDict = self.top_cmt.firstObject;
//        NSString *cmtStr = [NSString stringWithFormat:@"%@: %@",cmtDict[@"user"][@"username"],cmtDict[@"content"]];
//        _cellHeight += [cmtStr sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:maxSize].height;
//    }
//
//    //工具条
//    _cellHeight += 45;
//
//    return _cellHeight;
//
//}
- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 文字的Y值
    _cellHeight += 55;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(HWScreenW - 2 * 10, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height + 10;
    
    // 中间的内容
    if (self.type != HWTopicTypeWord) { // 中间有内容（图片、声音、视频）
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        
        if (middleH >= HWScreenH) {  //显示的图片高度超过一个屏幕 就是超长图片
            middleH = 200;
            self.bigPicture = YES;
        }
        CGFloat middleY = _cellHeight;
        CGFloat middleX = 10;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH + 10;
    }
    
    
    
    // 最热评论
    if (self.top_cmt.count) { // 有最热评论
        // 标题
        _cellHeight += 23;
        
        // 内容
        NSDictionary *cmt = self.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _cellHeight += [cmtText boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + 10;
    }
    
    // 工具条
    _cellHeight += 35 + 10;
    
    return _cellHeight;
}

@end
    
