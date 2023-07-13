//
//  TopView.h
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//
//一条说说的顶部视图，应该有头像，名字
#import <UIKit/UIKit.h>


@interface TopView : UIView

@property(strong, nonatomic) UIImageView *iconImageView;
@property(strong, nonatomic) UILabel *nickNameLabel;
@property(strong, nonatomic) UILabel *dateLabel;

@end
