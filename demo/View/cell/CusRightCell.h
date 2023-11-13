

#import <UIKit/UIKit.h>
#import "KUILabel.h"

@interface CusRightCell : UITableViewCell

@property (nonatomic, strong) KUILabel *send;

- (void)refreshCellWithText:(NSString *)text;

@end
