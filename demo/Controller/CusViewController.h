
#import <UIKit/UIKit.h>

@interface CusViewController : UIViewController<UITextFieldDelegate>
@property(strong, nonatomic) NSString *friendImgName;
@property(strong, nonatomic) NSString *friendName;
@property(strong, nonatomic) NSMutableArray<NSNumber *> *isSender; // 用于判断当前用户是不是消息的发送者
@property(strong, nonatomic) NSMutableArray *contentArray;
@end

