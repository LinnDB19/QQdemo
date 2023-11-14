//
//  ImageZoom.m
//  demo
//
//  Created by LinDaobin on 2023/10/27.
//

#import <Foundation/Foundation.h>
#import "ImageZoom.h"

@interface ImageZoom()

+(void)showImageAndAddHideTap:(UIImage *)image;
+(void)hideImage:(UITapGestureRecognizer *)tap;
@end

static NSArray<UIImage *> *imgs;
static NSUInteger idx;
static UIImageView *imageView;

@implementation ImageZoom

+(void)showImage:(UIImage *)contentImage
{
    [self showImageAndAddHideTap:contentImage];
}

+(void)showImages:(NSArray<UIImage *> *)contentImages at:(NSUInteger)index
{
    imgs = contentImages;
    idx = index;
    UIImage *image = contentImages[index];
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat width,height;
    width = size.width;  //宽度为屏幕宽度
    height = image.size.height * size.width / image.size.width; // 高度根据比例计算
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    collectionViewLayout.minimumLineSpacing = 0;
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewLayout.itemSize = UIScreen.mainScreen.bounds.size;
    UICollectionView *backgroundView = [[UICollectionView alloc]initWithFrame:UIScreen.mainScreen.bounds collectionViewLayout:collectionViewLayout];
    [backgroundView setContentOffset:CGPointMake(size.width * idx, 0) animated:NO];
    [backgroundView setAlpha:0];
    [UIView transitionWithView:backgroundView duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
    
        backgroundView.dataSource = self;
        backgroundView.pagingEnabled = YES;
        backgroundView.bounces = NO;
        [backgroundView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;    //背景
        [window addSubview:backgroundView];
        [window bringSubviewToFront:backgroundView];
        [backgroundView setAlpha:1];
    } completion:nil];
    //轻触关闭手势
    UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tap];
}

#pragma mark UIcollection datasoure

+ (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return imgs.count;
}

+ (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat width = size.width;  //宽度为屏幕宽度
    NSUInteger row = indexPath.row;
    CGFloat height = imgs[row].size.height * size.width / imgs[row].size.width; // 高度根据比例计算
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (size.height - height) * 0.5, width, height)];
    imageView.image = imgs[row];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    cell.backgroundView = imageView;
    cell.backgroundColor = [UIColor blackColor];
    
    return cell;
}

+(void)hideImage:(UITapGestureRecognizer *)tap{
    UIView *backgroundView = tap.view;
   [UIView animateWithDuration:0.3 animations:^{
       [backgroundView setAlpha:0];
   } completion:^(BOOL finished) {
       [backgroundView removeFromSuperview];
   }];
}

@end
