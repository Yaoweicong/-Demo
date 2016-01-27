//
//  YCWaterFllowLayout.h
//  瀑布流demo
//
//  Created by 姚伟聪 on 16/1/21.
//  Copyright © 2016年 姚伟聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCWaterFllowLayout;
@protocol  YCWaterFllowLayoutDelegate<NSObject>

-(CGFloat)waterFllowLayout:(YCWaterFllowLayout *)layout andHeightForWidth:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;

@end

@interface YCWaterFllowLayout : UICollectionViewLayout

@property(nonatomic,weak)id<YCWaterFllowLayoutDelegate>delegate;

@end
