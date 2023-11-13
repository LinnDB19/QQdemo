//
//  NormalTableVC.h
//  demo
//
//  Created by LinDaobin on 2023/11/2.
//

#ifndef NormalTableVC_h
#define NormalTableVC_h

#import "UIKit/UIKit.h"
@interface NormalTableVC : UITableViewController<UIGestureRecognizerDelegate>
@property(strong, nonatomic) UIPanGestureRecognizer *panGesture; // 平移
@end

#endif /* NormalTableVC_h */
