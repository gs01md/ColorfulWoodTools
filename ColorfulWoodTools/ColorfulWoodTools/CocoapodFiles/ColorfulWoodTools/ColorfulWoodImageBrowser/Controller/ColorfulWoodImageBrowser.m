//
//  ColorfulWoodImageBrowser.m
//  ColorfulWoodTools
//
//  Created by 大新 on 2018/12/24.
//  Copyright © 2018 ColorfulWood. All rights reserved.
//

#import "ColorfulWoodImageBrowser.h"
#import "CWCellImageBrowser.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <ColorfulWoodNavigationBar/ColorfulWoodNavigationBar.h>
#import "ColorfullWoodToolDefine.h"

@interface ColorfulWoodImageBrowser ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate
>

@property (nonatomic, strong) UICollectionView *m_collectionView;
@property (nonatomic, strong) ColorfulWoodNavigationBar *m_customNavigationBar;

/**
 * 进入时，是否显示了导航栏，需要区分操作：
 * 1. 进入时，导航栏应该隐藏
 * 2. 返回后，应该恢复
 */
@property (nonatomic, assign) BOOL m_isShowNaviWhenIn;
@end

@implementation ColorfulWoodImageBrowser

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    if (self.m_indexPath < self.m_imageArray.count) {
        [self.m_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.m_indexPath inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }

    if (self.navigationController && self.navigationController.isNavigationBarHidden == YES) {

        self.m_isShowNaviWhenIn = YES;
    }

}

-(void)viewDidDisappear:(BOOL)animated{

    if (self.m_isShowNaviWhenIn) {

        [self.navigationController setNavigationBarHidden: NO];
        [self.navigationController setNavigationBarHidden: NO animated: NO];
        self.navigationController.navigationBar.hidden = NO;

    }
    
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigation];
    [self setupUI];
}

- (void)setupNavigation{

    [self.view addSubview:self.m_customNavigationBar];
    self.m_customNavigationBar.barBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    self.m_customNavigationBar.titleLabelFont = [UIFont fontWithName:@"PingFang-SC-Medium" size:17];
    self.m_customNavigationBar.titleLabelColor = CWTDColorXRGB(0X1A1A1A);

    UIImage *img = ColorfulWoodNavigationBar_bundle_pngImg(@"back@2x");
    [self.m_customNavigationBar cw_setLeftButtonWithImage:img];
    self.m_customNavigationBar.backgroundColor = [UIColor whiteColor];

    self.m_customNavigationBar.title = [NSString stringWithFormat:@"%lu/%lu",self.m_indexPath + 1, self.m_imageArray.count];

    __weak __typeof(ColorfulWoodImageBrowser*) weakself = self;

    if (!self.m_isShowDelete) {
        [self.m_customNavigationBar cw_setRightButtonWithTitle:@"删除" titleColor:CWTDColorXRGB(0x1a1a1a)];
        [self.m_customNavigationBar setOnClickRightButton:^{
            [weakself clickDeleteBtn];
        }];
    }
}

#pragma mark - 删除图片
- (void)clickDeleteBtn{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确定要删除照片" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alertController addAction:cancelAction];

    UIAlertAction *determineAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        self.m_indexPath = self.m_collectionView.contentOffset.x / CWTDScreenWidth;
        [self.m_imageArray removeObjectAtIndex:self.m_indexPath];
        if(self.block_delete){
            self.block_delete(self.m_indexPath);
        }
        if (self.m_indexPath > 0) {
            self.m_indexPath -= 1;
        }else {
            self.m_indexPath = 0;
        }
        if (self.m_imageArray.count == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self.m_collectionView reloadData];
            [self.m_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.m_indexPath inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            self.m_customNavigationBar.title = [NSString stringWithFormat:@"%ld/%ld",self.m_indexPath + 1, self.m_imageArray.count];
        }
    }];
    [alertController addAction:determineAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)setupUI
{
    [self.view addSubview:self.m_collectionView];
    [self.m_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    [self.view insertSubview:self.m_customNavigationBar aboveSubview:self.view];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.m_imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CWCellImageBrowser *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CWCellImageBrowser" forIndexPath:indexPath];
    if (indexPath.row < self.m_imageArray.count) {
        if([self.m_imageArray[indexPath.row] isKindOfClass:[UIImage class]]) {

            [cell.m_pictureImageView setImage:self.m_imageArray[indexPath.row]];
        }else {
            [cell.m_pictureImageView sd_setImageWithURL:[NSURL URLWithString:self.m_imageArray[indexPath.row]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(error){
                    [cell.m_pictureImageView setImage:[UIImage imageNamed:@"默认图片"]];
                }else{
                    [self.m_imageArray replaceObjectAtIndex:indexPath.row withObject:image];
                }
            }];
        }
    }

    __weak __typeof(ColorfulWoodImageBrowser*) weakself = self;
    cell.block_tapImage = ^{
        if (weakself.m_customNavigationBar.hidden) {
            weakself.m_customNavigationBar.hidden = NO;
        }else {
            weakself.m_customNavigationBar.hidden = YES;
        }
    };
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.m_indexPath = scrollView.contentOffset.x / CWTDScreenWidth;

    self.m_customNavigationBar.title = [NSString stringWithFormat:@"%ld/%ld",self.m_indexPath + 1, self.m_imageArray.count];
}

#pragma mark - 懒加载
- (UICollectionView *)m_collectionView
{
    if (!_m_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(CWTDScreenWidth, CWTDScreenHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;

        _m_collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CWTDScreenWidth, CWTDScreenHeight) collectionViewLayout:layout];
        _m_collectionView.scrollsToTop = NO;
        _m_collectionView.showsVerticalScrollIndicator = NO;
        _m_collectionView.showsHorizontalScrollIndicator = NO;
        _m_collectionView.delegate = self;
        _m_collectionView.dataSource = self;
        _m_collectionView.pagingEnabled = YES;
        _m_collectionView.backgroundColor = [UIColor blackColor];
        [_m_collectionView registerClass:[CWCellImageBrowser class] forCellWithReuseIdentifier:@"CWCellImageBrowser"];
    }
    return _m_collectionView;
}

@end
