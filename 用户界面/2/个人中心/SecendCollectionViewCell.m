//
//  SecendCollectionViewCell.m
//  simpleXXL
//
//  Created by ZhiF_Zhu on 2020/3/15.
//  Copyright © 2020 ZhiF_Zhu. All rights reserved.
//

#import "SecendCollectionViewCell.h"


@implementation SecendCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat itemW = self.bounds.size.width;
        CGFloat itemH = self.bounds.size.height;

        self.secendImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (itemH-80)*0.5, 120, 80)];
        self.secendImageView.clipsToBounds = YES;
        self.secendImageView.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.secendImageView];
        
        self.contentTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.secendImageView.frame) + 10, (itemH-30)*0.5, 100, 30)];
        self.contentTitle.backgroundColor = [UIColor redColor];
        [self addSubview:self.contentTitle];
        
        self.subtitle = [[UILabel alloc] initWithFrame:CGRectMake(itemW - 100, (itemH-30)*0.5, 60, 30)];
        self.subtitle.backgroundColor = [UIColor magentaColor];
        [self addSubview:self.subtitle];
        
        self.rightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(itemW - 40, (itemH-30)*0.5, 30, 30)];
        self.rightIcon.backgroundColor = [UIColor greenColor];
        [self addSubview:self.rightIcon];
    }
    
    return self;
}


@end
