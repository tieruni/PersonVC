//
//  CZHDailyCheckInView.m
//  每日签到
//
//  Created by 程召华 on 2018/3/7.
//  Copyright © 2018年 程召华. All rights reserved.
//



#import "CZHDailyCheckInView.h"
#import "CZHDialyCheckInHeader.h"
#import "CZHLocalCacheTool.h"

typedef NS_ENUM(NSInteger, CZHDailyCheckInViewButtonType) {
    CZHDailyCheckInViewButtonTypeSure,
    CZHDailyCheckInViewButtonTypeCancle
};

@interface CZHTreasureBoxView ()
/**注释*/
@property (nonatomic, weak) UILabel *dayCount;
/**注释*/
@property (nonatomic, weak) UILabel *diamondCount;
/**注释*/
@property (nonatomic, weak) UIImageView *treasureBoxImage;
/**注释*/
@property (nonatomic, weak) UIView *maskView;
/**注释*/
@property (nonatomic, weak) UIImageView *bottomImage;
@end


@implementation CZHTreasureBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setView];
        
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    self.dayCount.text = title;
}

- (void)setDiamond:(NSString *)diamond {
    _diamond = diamond;
    self.diamondCount.text = diamond;
}

- (void)setIsCheckIng:(NSInteger)isCheckIng {
    _isCheckIng = isCheckIng;
    
    if (isCheckIng == 0) {
        self.maskView.hidden = NO;
        self.bottomImage.image = [UIImage imageNamed:@"UYDAWB_sign_cannot_sign"];
        self.treasureBoxImage.image = [UIImage imageNamed:self.notOpenImage];
    } else if(isCheckIng == 1) {
        self.maskView.hidden = NO;
        self.bottomImage.image = [UIImage imageNamed:@"UYDAWB_sign_can_sign"];
        self.treasureBoxImage.image = [UIImage imageNamed:self.notOpenImage];
    } else if(isCheckIng == 2) {
        self.maskView.hidden = YES;
        self.bottomImage.image = [UIImage imageNamed:@"UYDAWB_sign_cannot_sign"];
        self.treasureBoxImage.image = [UIImage imageNamed:self.isOpenImage];
    }
}



- (void)setView {
    UIImageView *bottomImage = [[UIImageView alloc] init];
    bottomImage.frame = CGRectMake(0, 0, self.czh_width, self.czh_height);
    //bottomImage.image = [UIImage imageNamed:@"UYDAWB_sign_cannot_sign"];
    [self addSubview:bottomImage];
    self.bottomImage = bottomImage;
    
    
    UILabel *dayCount = [[UILabel alloc] init];
    dayCount.frame = CGRectMake(0, CZH_ScaleHeight(6), self.czh_width, CZH_ScaleHeight(11));
    dayCount.textColor = CZHColor(0x333333);
    //    dayCount.text = @"第一天";
    dayCount.font = CZHGlobelNormalFont(12);
    dayCount.textAlignment = NSTextAlignmentCenter;
    [bottomImage addSubview:dayCount];
    self.dayCount = dayCount;
    
    UIImageView *treasureBoxImage = [[UIImageView alloc] init];
    treasureBoxImage.frame = CGRectMake(CZH_ScaleWidth(7.5), dayCount.czh_bottom + CZH_ScaleHeight(4), CZH_ScaleWidth(55), CZH_ScaleHeight(50));
    // treasureBoxImage.image = [UIImage imageNamed:@"UYDAWB_sign_firstday_open"];
    [bottomImage addSubview:treasureBoxImage];
    self.treasureBoxImage = treasureBoxImage;
    
    UILabel *diamondCount = [[UILabel alloc] init];
    diamondCount.frame = CGRectMake(0, treasureBoxImage.czh_bottom + CZH_ScaleHeight(4), self.czh_width, CZH_ScaleHeight(11));
    //    diamondCount.text = @"1币";
    diamondCount.textColor = CZHColor(0x333333);
    diamondCount.font = CZHGlobelNormalFont(12);
    diamondCount.textAlignment = NSTextAlignmentCenter;
    [bottomImage addSubview:diamondCount];
    self.diamondCount = diamondCount;
    
    UIView *maskView = [[UIView alloc] init];
    maskView.layer.cornerRadius = CZH_ScaleHeight(10);
    maskView.frame = bottomImage.frame;
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self addSubview:maskView];
    self.maskView = maskView;
}

@end




@interface CZHDailyCheckInView ()

/**背景图*/
@property (nonatomic, weak) UIImageView *backgroundImageView;
/**连续签到*/
@property (nonatomic, weak) UILabel *continueLabel;
/**数组*/
@property (nonatomic, strong) NSMutableArray *daysCount;
///<#注释#>
@property (nonatomic, weak) UIButton *receiveReward;
///签到成功回调
@property (nonatomic, copy) void (^successHandler)(CZHDailyCheckInView *checkInView);
///失败回调
@property (nonatomic, copy) void (^failureHandler)(CZHDailyCheckInView *checkInView);
///关闭回调
@property (nonatomic, copy) void (^closeHandler)(CZHDailyCheckInView *checkInView);
@end

@implementation CZHDailyCheckInView

- (NSMutableArray *)daysCount {
    if (!_daysCount) {
        _daysCount = [NSMutableArray array];
    }
    return _daysCount;
}


+ (instancetype)czh_dialyCheckInViewWithSuccessHandler:(void (^)(CZHDailyCheckInView *))successHandler failureHandler:(void (^)(CZHDailyCheckInView *))failureHandler closeHandler:(void (^)(CZHDailyCheckInView *))closeHandler {
    
    
    CZHDailyCheckInView *checkInView = [[CZHDailyCheckInView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    checkInView.successHandler = successHandler;
    
    checkInView.failureHandler = failureHandler;
    
    checkInView.closeHandler = closeHandler;
    
    
    return checkInView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self czh_getData];
    }
    return self;
}

- (void)czh_getData {
    
    /****以下是本地数据，模仿请求接口处理***/
    NSDictionary *checkCache = [CZHLocalCacheTool czh_getCheckCache];
    
    if (checkCache.count <= 0) {//第一次本地数据是空的，添加一个空的放到数据库
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"UYDAWB_sign_count"] = @"0";
        dic[@"UYDAWB_sign_log"] = @[];
        
        [CZHLocalCacheTool czh_updateCheckCacheWithDataDic:dic];
    } else {
        
        NSArray *array = [checkCache valueForKey:@"UYDAWB_sign_log"];
        
        if (array.count >= 7) {//如果连续7天签到完成，置空，模拟后台连续签到
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"UYDAWB_sign_count"] = @"0";
            dic[@"UYDAWB_sign_log"] = @[];
            
            [CZHLocalCacheTool czh_updateCheckCacheWithDataDic:dic];
        }
    }
    /****以上是本地数据，模仿请求接口处理****/

    ///下面是数据请求成功显示
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self czh_setUpView];
        
        [self czh_reloadDta];
        
//    });
    
}

- (void)czh_setUpView {
    
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.tag = 100000;
    backgroundImageView.userInteractionEnabled = YES;
    backgroundImageView.image = [UIImage imageNamed:@"UYDAWB_sign_background"];
    backgroundImageView.frame = CGRectMake(0, 0, CZH_ScaleWidth(315), CZH_ScaleHeight(350));
    backgroundImageView.czh_centerX = self.czh_centerX;
    backgroundImageView.czh_centerY = self.czh_centerY;
    backgroundImageView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    
    
    UIImageView *calendarImage = [[UIImageView alloc] init];
    calendarImage.frame = CGRectMake(CZH_ScaleWidth(15),CZH_ScaleHeight(15), CZH_ScaleWidth(31), CZH_ScaleHeight(31));
    calendarImage.image = [UIImage imageNamed:@"UYDAWB_sign_home_calendar"];
    [backgroundImageView addSubview:calendarImage];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"签到领取币";
    titleLabel.textColor = CZHColor(0xffffff);
    titleLabel.font = CZHGlobelNormalFont(18);
    titleLabel.frame = CGRectMake(calendarImage.czh_right + CZH_ScaleWidth(6), CZH_ScaleHeight(15), CZH_ScaleWidth(200), CZH_ScaleHeight(17));
    [backgroundImageView addSubview:titleLabel];
    
    
    UILabel *continueLabel = [[UILabel alloc] init];
    continueLabel.frame = CGRectMake(calendarImage.czh_right + CZH_ScaleWidth(6), titleLabel.czh_bottom + CZH_ScaleHeight(5), CZH_ScaleWidth(200), CZH_ScaleHeight(12));
    continueLabel.text = @"连续签到0天";
    continueLabel.textColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.8];
    continueLabel.font = CZHGlobelNormalFont(12);
    [backgroundImageView addSubview:continueLabel];
    self.continueLabel = continueLabel;
    
    //关闭
    UIButton *closeButton = [[UIButton alloc] init];
    closeButton.frame = CGRectMake( CZH_ScaleWidth(283), CZH_ScaleHeight(5), CZH_ScaleWidth(22), CZH_ScaleHeight(22));
    closeButton.tag = CZHDailyCheckInViewButtonTypeCancle;
    [closeButton setBackgroundImage:[UIImage imageNamed:@"UYDAWB_sign_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImageView addSubview:closeButton];
    
    
    CZHTreasureBoxView *first = [self czh_quickSetUpViewWithFrame:CGRectMake(CZH_ScaleWidth(10), CZH_ScaleHeight(75), CZH_ScaleWidth(70), CZH_ScaleHeight(93)) currentDay:1];
   
    CZHTreasureBoxView *second = [self czh_quickSetUpViewWithFrame:CGRectMake(first.czh_right + CZH_ScaleWidth(5), CZH_ScaleHeight(75), CZH_ScaleWidth(70), CZH_ScaleHeight(93)) currentDay:2];
    
    CZHTreasureBoxView *third = [self czh_quickSetUpViewWithFrame:CGRectMake(second.czh_right + CZH_ScaleWidth(5), CZH_ScaleHeight(75), CZH_ScaleWidth(70), CZH_ScaleHeight(93)) currentDay:3];
    

    CZHTreasureBoxView *fourth = [self czh_quickSetUpViewWithFrame:CGRectMake(third.czh_right + CZH_ScaleWidth(5), CZH_ScaleHeight(75), CZH_ScaleWidth(70), CZH_ScaleHeight(93)) currentDay:4];
    
    
    CZHTreasureBoxView *fifth = [self czh_quickSetUpViewWithFrame:CGRectMake(CZH_ScaleWidth(47.5), first.czh_bottom + CZH_ScaleHeight(6), CZH_ScaleWidth(70), CZH_ScaleHeight(93)) currentDay:5];
    
    CZHTreasureBoxView *sixth = [self czh_quickSetUpViewWithFrame:CGRectMake(CZH_ScaleWidth(5) + fifth.czh_right, first.czh_bottom + CZH_ScaleHeight(6), CZH_ScaleWidth(70), CZH_ScaleHeight(93)) currentDay:6];
    
    CZHTreasureBoxView *seventh = [self czh_quickSetUpViewWithFrame:CGRectMake(CZH_ScaleWidth(5) + sixth.czh_right, first.czh_bottom + CZH_ScaleHeight(6), CZH_ScaleWidth(70), CZH_ScaleHeight(93)) currentDay:7];

    //签到
    UIButton *receiveReward = [[UIButton alloc] init];
    receiveReward.frame = CGRectMake(CZH_ScaleWidth(36.5), seventh.czh_bottom + CZH_ScaleHeight(21), CZH_ScaleWidth(242), CZH_ScaleHeight(41));
    [receiveReward setBackgroundImage:[UIImage imageNamed:@"UYDAWB_sign_receive_reward"] forState:UIControlStateNormal];
    receiveReward.tag = CZHDailyCheckInViewButtonTypeSure;
    [receiveReward addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [backgroundImageView addSubview:receiveReward];
    self.receiveReward = receiveReward;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self czh_showView];
    
}


//签到领取奖励事件
- (void)buttonClick:(UIButton *)sender {
    
    if (sender.tag == CZHDailyCheckInViewButtonTypeCancle) {
        
        [self czh_hideView];
        
        if (self.closeHandler) {
            self.closeHandler(self);
        }
    
    } else if (sender.tag == CZHDailyCheckInViewButtonTypeSure) {
        //模拟请求接口签到
        [BaseNetworkTool requesetPostWithUrl:@"/users/test_charge" andParams:@{@"gold":@(10)} withSucessBlock:^(id response) {
            [MBProgressHUD showOnlyText:@"签到成功"];
            [[NSUserDefaults standardUserDefaults]setValue:@"1" forKey:@"YYCCLick"];
            [[NSUserDefaults standardUserDefaults]synchronize];
        } andfailureBlock:^(NSError *error) {
            
        }];
        [self czh_checkIn];
    }
}


- (void)czh_checkIn {
    
    
    /*****以下模拟请求成功更新数据******/
    
    NSMutableDictionary *signDictionary = [[CZHLocalCacheTool czh_getCheckCache] mutableCopy];
    
    NSString *sign_count = [signDictionary valueForKey:@"UYDAWB_sign_count"];
    
    NSInteger signCount = [sign_count integerValue];
    
    NSArray *array = [signDictionary valueForKey:@"UYDAWB_sign_log"];
    
    NSMutableArray *templeArray = [array mutableCopy];

    //签到获得的金币数量
    if (signCount < 7) {
        
        signCount++;
        
        NSDictionary *dic = @{@"coin" : @"10"};
        [templeArray addObject:dic];
        
    } else if (signCount >= 7) {
    
        signCount = 0;
        [templeArray removeAllObjects];
    }
    
    
    [signDictionary setValue:[NSString stringWithFormat:@"%ld", signCount] forKey:@"UYDAWB_sign_count"];
    
    [signDictionary setValue:[templeArray copy] forKey:@"UYDAWB_sign_log"];
    
    
    [CZHLocalCacheTool czh_updateCheckCacheWithDataDic:signDictionary];
    
    ///签到成功让后台把所有的数据一起返回
    /*****以上模拟请求成功更新数据******/
    
    
    //签到一次之后,签到按钮不可点击
//    NSDate *NowTime = [NSDate date];
    
    
    self.receiveReward.enabled = NO;
    self.receiveReward.alpha = 0.5;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self czh_reloadDta];
        
        if (self.successHandler) {
            self.successHandler(self);
        }
    });
}

- (void)czh_reloadDta {
    
    NSDictionary *signDictionary = [CZHLocalCacheTool czh_getCheckCache];
    
    NSArray *array = signDictionary[@"UYDAWB_sign_log"];
    
    self.continueLabel.text = [NSString stringWithFormat:@"连续签到%ld天", [signDictionary[@"UYDAWB_sign_count"] integerValue]];
    
    for (NSInteger i = 0; i < self.daysCount.count; i++) {
        CZHTreasureBoxView *days = self.daysCount[i];
        if (i < array.count) {//小于7天
            NSDictionary *dic = array[i];
            
            days.diamond = @"10币";
            days.isCheckIng = 2;
        }else if (i == array.count) {//第七天
            days.diamond = @"10币";
            days.isCheckIng = 1;
        } else {
            days.diamond = @"*币";
            days.isCheckIng = 0;
        }
    }
}

//蒙板
- (void)czh_showView {
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        self.backgroundImageView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);;
        
    } completion:nil];
}

//移除蒙板
- (void)czh_hideView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.backgroundImageView.transform = CGAffineTransformMakeScale(0.01f, 0.01f);;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (CZHTreasureBoxView *)czh_quickSetUpViewWithFrame:(CGRect)frame currentDay:(NSInteger)currentDay {
    
    CZHTreasureBoxView *boxView = [[CZHTreasureBoxView alloc] initWithFrame:frame];
    boxView.title = [NSString stringWithFormat:@"第%ld天", currentDay];
    boxView.isOpenImage = [NSString stringWithFormat:@"UYDAWB_sign_open_%ld", currentDay];
    boxView.notOpenImage = [NSString stringWithFormat:@"UYDAWB_sign_close_%ld", currentDay];
    [self.backgroundImageView addSubview:boxView];
    [self.daysCount addObject:boxView];
    
    return boxView;
}

@end




