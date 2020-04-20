//
//  UsersViewController.m
//  SLPMoodFM
//
//  Created by 朱洁珊 on 2019/12/19.
//  Copyright © 2019 朱洁珊. All rights reserved.
//

#import "UsersViewController.h"
#import "SDImageCache.h"
#import "SLPAboutUSViewController.h"

@interface UsersViewController ()
@property (strong, nonatomic) IBOutlet UIView *SLPView1;
@property (strong, nonatomic) IBOutlet UIView *SLPView2;
@property (strong, nonatomic) IBOutlet UIView *SLPView3;
@property (strong, nonatomic) IBOutlet UIView *SLPView4;

@end

@implementation UsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"我的"];
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1Action)];
    [self.SLPView1 addGestureRecognizer:tapG];
    
    UITapGestureRecognizer *tapG1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap2Action)];
    [self.SLPView2 addGestureRecognizer:tapG1];
    
    UITapGestureRecognizer *tapG2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap3Action)];
    [self.SLPView3 addGestureRecognizer:tapG2];
    
    UITapGestureRecognizer *tapG3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap4Action)];
    [self.SLPView4 addGestureRecognizer:tapG3];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)tap1Action{
    [[SDImageCache sharedImageCache] clearMemory];
    //磁盘
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    
    //2.自定义缓存
    NSString *my_CachePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    [[NSFileManager defaultManager] removeItemAtPath:my_CachePath error:nil];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.layer.cornerRadius = 12;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.layer.masksToBounds = YES;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"清除缓存成功";
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}

-(void)tap2Action{
    // 1、设置分享的内容，并将内容添加到数组中
    NSArray *activityItemsArray = @[@"AppStore请搜索SPMoodFM下载。失眠好烦躁？开车好无聊？听SPMoodFM，让你轻松度过闲暇时光"];
    NSArray *activityArray = @[];
    
    // 2、初始化控制器，添加分享内容至控制器
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItemsArray applicationActivities:activityArray];
    activityVC.modalInPopover = YES;
    // 3、设置回调
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // ios8.0 之后用此方法回调
        UIActivityViewControllerCompletionWithItemsHandler itemsBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
            NSLog(@"activityType == %@",activityType);
            if (completed == YES) {
                NSLog(@"completed");
            }else{
                NSLog(@"cancel");
            }
        };
        activityVC.completionWithItemsHandler = itemsBlock;
    }else{
        // ios8.0 之前用此方法回调
        UIActivityViewControllerCompletionHandler handlerBlock = ^(UIActivityType __nullable activityType, BOOL completed){
            NSLog(@"activityType == %@",activityType);
            if (completed == YES) {
                NSLog(@"completed");
            }else{
                NSLog(@"cancel");
            }
        };
        activityVC.completionHandler = handlerBlock;
    }
    // 4、调用控制器
    [self presentViewController:activityVC animated:YES completion:nil];
}

-(void)tap3Action{
    SLPAboutUSViewController *vc = [[SLPAboutUSViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)tap4Action{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.layer.cornerRadius = 12;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.layer.masksToBounds = YES;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"反馈邮箱:slpmoodfmapp@163.com";
    hud.removeFromSuperViewOnHide = YES;
    // 2秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
