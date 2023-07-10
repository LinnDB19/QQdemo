//
//  personCell.h
//  demo
//
//  Created by Abakus on 2023/6/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonCell : UITableViewCell

@property(strong, nonatomic) UIView *topSepaView;
@property(strong, nonatomic) UIView *botSepaView;

-(void)setFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
