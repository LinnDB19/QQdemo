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

@implementation ImageZoom

+(void)showImage:(UIImage *)contentImage
{
    [self showImageAndAddHideTap:contentImage];
}

+(void)showImageAndAddHideTap:(UIImage *)image
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [backgroundView setBackgroundColor:[UIColor blackColor]];
    //动画放大所展示的ImageView
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat y,width,height;
        width = size.width;  //宽度为屏幕宽度
        height = image.size.height * size.width / image.size.width; // 高度根据比例计算
        UIImageView *imageView = [UIImageView new];
        imageView.image = image;
        //设置frame才会有动画，初始化直接设置就没有动画
        [imageView setFrame:CGRectMake(0, (size.height - height) * 0.5, width, height)];
        [backgroundView addSubview:imageView];
        [backgroundView setAlpha:1];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;    //背景
        [window addSubview:backgroundView];
        [window bringSubviewToFront:backgroundView];
    }];// completion:^(BOOL finished) { }];
    //轻触关闭手势
    UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tap];
}

+(void)hideImage:(UITapGestureRecognizer *)tap{
    UIView *backgroundView = tap.view;
   [UIView animateWithDuration:0.5 animations:^{
       [backgroundView setAlpha:0];
   } completion:^(BOOL finished) {
       [backgroundView removeFromSuperview];
   }];
}

@end
