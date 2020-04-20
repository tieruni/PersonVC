//
//  UIView+TFExtension.m
//  QTake
//
//  Created by mac on 16/7/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIView+TFExtension.h"

@implementation UIView (TFExtension)

- (CGSize)qjyysize
{
    return self.frame.size;
}

- (void)setQjyysize:(CGSize)qjyysize
{
    CGRect frame = self.frame;
    frame.size = qjyysize;
    self.frame = frame;
}

- (CGFloat)qjyywidth
{
    return self.frame.size.width;
}

- (CGFloat)qjyyheight
{
    return self.frame.size.height;
}

- (void)setQjyywidth:(CGFloat)qjyywidth
{
    CGRect frame = self.frame;
    frame.size.width = qjyywidth;
    self.frame = frame;
}

- (void)setQjyyheight:(CGFloat)qjyyheight
{
    CGRect frame = self.frame;
    frame.size.height = qjyyheight;
    self.frame = frame;
}

- (CGFloat)qjyyx
{
    return self.frame.origin.x;
}

- (void)setQjyyx:(CGFloat)qjyyx
{
    CGRect frame = self.frame;
    frame.origin.x = qjyyx;
    self.frame = frame;
}

- (CGFloat)qjyyy
{
    return self.frame.origin.y;
}

- (void)setQjyyy:(CGFloat)qjyyy
{
    CGRect frame = self.frame;
    frame.origin.y = qjyyy;
    self.frame = frame;
}

- (CGFloat)qjyycenterX
{
    return self.center.x;
}

- (void)setQjyycenterX:(CGFloat)qjyycenterX
{
    CGPoint center = self.center;
    center.x = qjyycenterX;
    self.center = center;
}

- (CGFloat)qjyycenterY
{
    return self.center.y;
}

- (void)setQjyycenterY:(CGFloat)qjyycenterY
{
    CGPoint center = self.center;
    center.y = qjyycenterY;
    self.center = center;
}

- (CGFloat)qjyyright
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)qjyybottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setQjyyright:(CGFloat)qjyyright
{
    self.qjyyx = qjyyright - self.qjyywidth;
}

- (void)setQjyybottom:(CGFloat)qjyybottom
{
    self.qjyyy = qjyybottom - self.qjyyheight;
}
@end
