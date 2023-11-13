//
//  BottomView.h
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

//一条说说底部的view, 应该有三个按钮, 分别是点赞，评论，分享

#import <UIKit/UIKit.h>
#import "Delegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BottomView : UIView
@property (strong, nonatomic) UIButton *likeBtn;
@property (strong, nonatomic) UIButton *transmitBtn;
@property (strong, nonatomic) UIButton *commentBtn;
@property (weak, nonatomic) id<CommentDelegate> commentDelegate;
@property (weak, nonatomic) id<TransDelegate> transDelegate;
@end

NS_ASSUME_NONNULL_END
