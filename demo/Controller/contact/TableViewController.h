//
//  TableViewController.h
//  demo
//
//  Created by Abakus on 2023/6/27.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NormalTableVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : NormalTableVC<UIGestureRecognizerDelegate>
@property(assign) BOOL somethingEditing; //用于外部判断此时所处的上层scrollView是否应该滑动
@end

NS_ASSUME_NONNULL_END
