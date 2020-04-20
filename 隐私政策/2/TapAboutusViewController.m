//
//  TapAboutusViewController.m
//  TapTapMusic
//
//  Created by 朱洁珊 on 2019/10/25.
//  Copyright © 2019 朱洁珊. All rights reserved.
//

#import "TapAboutusViewController.h"

@interface TapAboutusViewController ()

@end

@implementation TapAboutusViewController
#pragma mark -- LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUI];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark -- LoadRequest


#pragma mark -- Event
-(void)tapbackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- Delegate


#pragma mark -- UI
-(void)setUI{
    self.title = @"关于我们" ;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15*kWidthScale, 18*kWidthScale, 40*kWidthScale, 40*kWidthScale);
    [backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(tapbackAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backBtn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-64)];
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(kScreenWidth, 1024);
    scrollView.showsVerticalScrollIndicator = YES;
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreenWidth-30, 1024)];
    contentLabel.text = @"我们极度重视您的用户隐私。您在使用我们的服务时，我们可能会收集和使用您的相关信息。我们希望通过本《隐私政策》向您说明，在使用我们的服务时，我们如何收集、使用、储存和分享这些信息，以及我们为您提供的访问、更新、控制和保护这些信息的方式。本《隐私政策》与您所使用的服务息息相关，希望您仔细阅读，在需要时，按照本《隐私政策》的指引，作出您认为适当的选择。本《隐私政策》中涉及的相关技术词汇，我们尽量以简明扼要的表述，并提供进一步说明的链接，以便您的理解。\n您使用或继续使用我们的服务，即意味着同意我们按照本《隐私政策》收集、使用、储存和分享您的相关信息。\n\n1 日志信息，指您使用我们的服务时，系统可能通过cookies或其他方式自动采集的技术信息，包括：\n\n1.1 设备或软件信息，例如您的移动设备或用于接入我们服务的其他程序所提供的配置信息、您的IP地址和移动设备所用的版本和设备识别码；\n1.2 在使用我们服务时搜索或浏览的信息，例如您在使用我们服务时浏览或要求提供的其他信息和内容详情；\n1.3 您通过我们的服务分享的内容所包含的信息（元数据），例如拍摄或上传的共享照片等\n\n2. 您提供的信息\n\n2.1您通过我们的服务向其他方提供的共享信息，以及您使用我们的服务时所储存的信息；\n2.2其他方分享的您的信息；\n2.3其他方使用我们的服务时所提供有关您的共享信息。\n\n3. 我们可能将在向您提供服务的过程之中所收集的信息用作下列用途：\n\n3.1向您提供服务；\n3.2在我们提供服务时，用于身份验证、客户服务、安全防范、诈骗监测、存档和备份用途，\n3.3确保我们向您提供的产品和服务的安全性；\n3.4帮助我们设计新服务，改善我们现有服务；\n\n如您对本《隐私政策》或相关事宜有任何问题，或者对我们服务有什么建议，请直接与我们联系反馈";
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor colorWithWhite:0 alpha:0.99];
    [scrollView addSubview:contentLabel];
}

#pragma mark -- Setter And Getter

-(void)dealloc{
    
}

@end
