//
//  BodyView.h
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

#import <UIKit/UIKit.h>
#import "TextBodyView.h"
#import "PicBodyView.h"

@interface BodyView : UIView

@property(strong, nonatomic) TextBodyView *textBodyView;
@property(strong, nonatomic) PicBodyView *picBodyView;

- (void) setPicBodyImageCount:(int)count;

@end

