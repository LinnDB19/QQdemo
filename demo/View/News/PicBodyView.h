//
//  PicBodyView.h
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//


#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface PicBodyView : UIView

@property(strong, nonatomic) NSMutableArray<UIImageView *> *imageViews; // 用来存放imageView的数组，不固定

- (void) setImageCount:(int)count;

@end

