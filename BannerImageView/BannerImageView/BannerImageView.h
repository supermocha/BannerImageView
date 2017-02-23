//
//  BannerImageView.h
//  BannerImageView
//
//  Created by Yuchi Chen on 2017/2/23.
//  Copyright © 2017年 Yuchi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

//scrollView的滾動方向
typedef NS_ENUM(NSInteger, ScrollingDirection)
{
    HorizontalScrolling = 0,
    VeritcalScrolling,
};

@protocol BannerImageViewDelegate <NSObject>

@optional
- (void)bannerImageViewDidSelectImageAtIndex:(NSInteger)index;

@end

@interface BannerImageView : UIView

- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSMutableArray *)imageNames scrollingDirection:(ScrollingDirection)direction;

@property (nonatomic, weak) id<BannerImageViewDelegate>delegate;
@property (nonatomic, assign) ScrollingDirection scrollingDirection;
@property (nonatomic, assign) BOOL hasPageControl;
@property (nonatomic) UIViewContentMode contentMode;

@end
