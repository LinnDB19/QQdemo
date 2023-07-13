//
//  ANew.h
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//
//一条说说的View

#import <UIKit/UIKit.h>
#import "TopView.h"
#import "BodyView.h"
#import "BottomView.h"
#import "TopView.h"

@interface ANewView : UIView

@property(strong, nonatomic) TopView *topView;
@property(strong, nonatomic) BodyView *bodyView;
@property(strong, nonatomic) BottomView *bottomView;


@end

