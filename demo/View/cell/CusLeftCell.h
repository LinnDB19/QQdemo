

#import <UIKit/UIKit.h>
#import "KUILabel.h"

@interface CusLeftCell : UITableViewCell

@property (nonatomic, strong) KUILabel *send;

- (void)refreshCellWithText:(NSString *)text;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithImgName:(NSString *)imgName;

@end
