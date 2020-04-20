//
//  HomeListViewController.m
//  PirateCottage
//
//  Created by ZhiF_Zhu on 2020/3/13.
//  Copyright © 2020 朱洁珊. All rights reserved.
//

#import "HomeListViewController.h"

static NSString * secenCellID = @"secdCellID";

static CGFloat kMagin = 10.f;

@interface HomeListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionViewFlowLayout *flowLayout;
@property(strong,nonatomic)UICollectionView *homeListCollection;
@property(strong,nonatomic)NSMutableArray *itemArr;

//头部视图
@property(strong,nonatomic)UIView *waitView;

//构建数组
@property(strong,nonatomic)NSMutableArray *titleArr;
@property(strong,nonatomic)NSMutableArray *picArr;

@end

@implementation HomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatHeaderViewframe];
    
    [self initWithHomeListCollectionView];

}

#pragma mark --初始化首页列表
- (void)creatHeaderViewframe{
    //框架
    self.waitView = [[UIView alloc] init];
    self.waitView.frame = CGRectMake(0 ,0 , kScreenWidth - 2*kMagin, 180);
    self.waitView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.waitView];
    
    CGFloat headerUserWidth = self.waitView.bounds.size.width;
    
    //用户信息
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, kMagin,  headerUserWidth, 80);
    headerView.layer.cornerRadius = 10;
    
    headerView.backgroundColor = [UIColor blueColor];
    [self.waitView addSubview:headerView];
    
    //心情日记
    UIView *bolieView = [[UIView alloc] init];
    bolieView.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame)+2*kMagin, headerUserWidth, 60);
    bolieView.layer.cornerRadius = 10;
    
    bolieView.backgroundColor = [UIColor brownColor];
    //表情
    UIImageView *jioicon = [[UIImageView alloc] init];
    jioicon.frame = CGRectMake(kMagin, kMagin, 40, 40);
    jioicon.backgroundColor = [UIColor purpleColor];
    [bolieView addSubview:jioicon];
    
    //左边标签
    UILabel *xinqingLb = [[UILabel alloc] init];
    xinqingLb.frame = CGRectMake(CGRectGetMaxX(jioicon.frame)+kMagin, kMagin+5, 100, 30);
    xinqingLb.backgroundColor = [UIColor lightGrayColor];
    [bolieView addSubview:xinqingLb];
    
    //右边箭头
    UIImageView *recIcon = [[UIImageView alloc] init];
    recIcon.frame = CGRectMake(bolieView.bounds.size.width-30-kMagin, kMagin+5, 30, 30);
    recIcon.backgroundColor = [UIColor greenColor];
    [bolieView addSubview:recIcon];
    [self.waitView addSubview:bolieView];
}

- (void)initWithHomeListCollectionView{
    
    //初始化流布局视图
    [self.view addSubview:self.homeListCollection];
    
}

- (UICollectionView *)homeListCollection{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (self.view.frame.size.width - 2 * kMagin);

    //设置单元格大小
    
    self.flowLayout.itemSize = CGSizeMake(itemWidth, 110);//item大小
    
    //最小行间距(默认为10)
    
    self.flowLayout.minimumLineSpacing = 10;
    
    //最小item间距（默认为10）
    
    self.flowLayout.minimumInteritemSpacing = 10;
    
    //设置senction的内边距
    
    self.flowLayout.sectionInset = UIEdgeInsetsMake(kMagin, kMagin, kMagin, kMagin);
    
    //设置UICollectionView的滚动方向（纵向）,如果是垂直滚动的,其item是横向排列的,反之亦然
    
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//排列方向(纵向)
    
    //sectionHeader的大小,如果是竖向滚动，只需设置Y值。如果是横向，只需设置X值。
    
    self.flowLayout.headerReferenceSize = CGSizeMake(itemWidth, 180);
    
    _homeListCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) collectionViewLayout:self.flowLayout];
    _homeListCollection.delegate = self;
    _homeListCollection.dataSource = self;
//    _homeListCollection.backgroundColor = [UIColor magentaColor];
    _homeListCollection.contentInset = UIEdgeInsetsMake(kMagin, kMagin, 0, kMagin);//上左下右
//    _homeListCollection.contentSize = CGSizeMake(0, 800);
    //注册cell
    [_homeListCollection registerClass:[SecendCollectionViewCell class] forCellWithReuseIdentifier:secenCellID];

    return _homeListCollection;
}

-(NSMutableArray *)itemArr{
    if (!_itemArr) {
        _itemArr = [NSMutableArray arrayWithArray:@[@"Disvam_21",@"Disvam_22",@"Disvam_23",@"Disvam_24",@"Disvam_23"]];
    }
    return _itemArr;
}

#pragma mark -- DataSource
//section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//每个section里有多少个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 4;
//    }
//    else{
//        return 2;
//    }
    return 5;

}

//自定义cell的样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    if (indexPath.section == 0) {
//
//        [collectionView registerClass:[SecendCollectionViewCell class] forCellWithReuseIdentifier:secenCellID];
//        SecendCollectionViewCell *collCell = [collectionView dequeueReusableCellWithReuseIdentifier:secenCellID forIndexPath:indexPath];
//        [collCell sizeToFit];
//
//        collCell.secendImageView.image = [UIImage imageNamed:self.itemArr[indexPath.section]];
//        collCell.backgroundColor = [UIColor yellowColor];
//
//        return collCell;
//
//    }else{
//        [collectionView registerClass:[SecendCollectionViewCell class] forCellWithReuseIdentifier:secenCellID];
//        SecendCollectionViewCell *sececdCell = [collectionView dequeueReusableCellWithReuseIdentifier:secenCellID forIndexPath:indexPath];
//        sececdCell.secendImageView = [UIImageView new];
//        sececdCell.contentTitle.text = @"XXXXX";
//
//        return sececdCell;
//
//    }
    
    [collectionView registerClass:[SecendCollectionViewCell class] forCellWithReuseIdentifier:secenCellID];
    SecendCollectionViewCell *collCell = [collectionView dequeueReusableCellWithReuseIdentifier:secenCellID forIndexPath:indexPath];
    [collCell sizeToFit];
    
    collCell.secendImageView.image = [UIImage imageNamed:self.itemArr[indexPath.row]];
    collCell.contentTitle.text = self.titleArr[indexPath.row];
    collCell.rightIcon.image = [UIImage imageNamed:@""];
    collCell.backgroundColor = [UIColor yellowColor];
    
    return collCell;
    
}

//集合视图头部或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //防止复用时头部头部内容重叠
//    NSString *identifier=[NSString stringWithFormat:@"%ld",(long)indexPath.section];
    NSString *identifier = @"header";

    //必须通过注册才能生效
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        //自定义头部View

        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath];
        
        headerView.backgroundColor = [UIColor orangeColor];
        
        if (indexPath.section == 0) {
            
            [headerView addSubview:self.waitView];
        }
        
        /*
        UILabel *label = [[UILabel alloc] initWithFrame:headerView.bounds];
        //头部字体大小
        label.font = [UIFont systemFontOfSize:14];
        if (indexPath.section == 0) {
            
            label.text = @"这是collectionView0的头部";
        }
        
        else if (indexPath.section == 1){
            label.text = @"这是collectionView1的头部";
        }
        else{
            label.text = @"这是collectionView的其他头部";
        }
        */
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
        UICollectionReusableView *supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath];
        supplementaryView.backgroundColor = [UIColor redColor];
        return supplementaryView;
    }
    return nil;
}

#pragma mark -- Delegate
//item点击调用的f代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击跳转");
    //@[@"背包",@"战绩",@"流水记录",@"客服",@"通知"];
    switch (indexPath.row) {
        case 0:{
            YYCNewPackaheViewController *vc = [[YYCNewPackaheViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 1:{
            YYCNewGameRViewController *vc = [[YYCNewGameRViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 2:{
            YYCNewGFlowViewController *vc = [[YYCNewGFlowViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 3:{
            YYCNewCSViewController *vc = [[YYCNewCSViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 4:{
            YYCNewNotiViewController *vc = [[YYCNewNotiViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        default:
            break;
    }
    /*
    if (tapG.view.tag == 200) {
        YYCNewPackaheViewController *vc = [[YYCNewPackaheViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tapG.view.tag == 201) {
        YYCNewGameRViewController *vc = [[YYCNewGameRViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tapG.view.tag == 202) {
        YYCNewGFlowViewController *vc = [[YYCNewGFlowViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tapG.view.tag == 203) {
        YYCNewCSViewController *vc = [[YYCNewCSViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (tapG.view.tag == 204) {
        YYCNewNotiViewController *vc = [[YYCNewNotiViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    */
}

#pragma mark -- Setter And Getter

- (NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithArray:@[@"背包",@"战绩",@"流水记录",@"客服",@"通知"]];
    }
    return _titleArr;
}

- (NSMutableArray *)picArr{
    if (!_picArr) {
        _picArr = [NSMutableArray arrayWithArray:@[@"Laleg_bag",@"Laleg_adr",@"Laleg_home",@"Laleg_cs",@"Laleg_about"]];
    }
    return _picArr;
}

@end
