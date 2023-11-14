//
//  ImageZoom.h
//  demo
//
//  Created by LinDaobin on 2023/10/27.
//

#ifndef ImageZoom_h
#define ImageZoom_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageZoom : NSObject<UICollectionViewDataSource>

//+(void)showImage:(UIImage *)contentImage;
+(void)showImages:(NSArray<UIImage *> *)contentImages at:(NSUInteger)index;
@end
#endif /* ImageZoom_h */
