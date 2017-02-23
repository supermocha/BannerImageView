//
//  BannerImageView.m
//  BannerImageView
//
//  Created by Yuchi Chen on 2017/2/23.
//  Copyright © 2017年 Yuchi Chen. All rights reserved.
//

#import "BannerImageView.h"

@interface BannerImageView () <UIScrollViewDelegate>
{
    UIPageControl *pageControl;
    NSMutableArray *images;
    NSInteger currentFirstPageIndex;
}
@end

@implementation BannerImageView

- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSMutableArray *)imageNames scrollingDirection:(ScrollingDirection)direction
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollingDirection = direction;
        [self setImagesWithNames:imageNames];
        [self setScrollView];
    }
    return self;
}

#pragma mark - Setter

- (void)setHasPageControl:(BOOL)bl
{
    _hasPageControl = bl;
    if (_hasPageControl) {
        [self setPageControl];
    }
}

- (void)setContentMode:(UIViewContentMode)contentMode
{
    for (UIImageView *imageView in self.subviews[0].subviews) {
        imageView.contentMode = contentMode;
    }
}

#pragma mark - Private

- (void)setScrollView
{
    if (self.subviews.count > 0) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.pagingEnabled = true;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = false;
    scrollView.showsVerticalScrollIndicator = false;
    [self addSubview:scrollView];
    
    switch (self.scrollingDirection) {
        case HorizontalScrolling:
            [self setHorizontalScrollView:scrollView];
            break;
            
        case VeritcalScrolling:
            [self setVerticalScrollView:scrollView];
            break;
            
        default:
            break;
    }
}

- (void)setImagesWithNames:(NSMutableArray *)imageNames
{
    images = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < imageNames.count + 2; i ++) {
        if (i == 0) {
            [images addObject:[UIImage imageNamed:[imageNames lastObject]]];
        }
        else if (i == imageNames.count + 1) {
            [images addObject:[UIImage imageNamed:[imageNames firstObject]]];
        }
        else {
            [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i - 1]]];
        }
    }
}

- (void)setHorizontalScrollView:(UIScrollView *)scrollView
{
    CGFloat width = CGRectGetWidth(scrollView.frame);
    CGFloat height = CGRectGetHeight(scrollView.frame);
    
    scrollView.contentSize = CGSizeMake(width * 3, height);
    
    //循環添加view
    for (NSInteger i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        imageView.image = [images objectAtIndex:i];
        imageView.userInteractionEnabled = true;
        //新增手勢
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [imageView addGestureRecognizer:tapGesture];
        //添加view到scrollView上
        [scrollView addSubview:imageView];
    }
    
    //設置初始滾動的位置為第二個view
    scrollView.contentOffset = CGPointMake(width, 0);
}

- (void)setVerticalScrollView:(UIScrollView *)scrollView
{
    CGFloat width = CGRectGetWidth(scrollView.frame);
    CGFloat height = CGRectGetHeight(scrollView.frame);
    
    scrollView.contentSize = CGSizeMake(width, height * 3);
    
    //循環添加view
    for (NSInteger i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i * height, width, height)];
        imageView.image = [images objectAtIndex:i];
        imageView.userInteractionEnabled = true;
        //新增手勢
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagePressed:)];
        [imageView addGestureRecognizer:tapGesture];
        //添加view到scrollView上
        [scrollView addSubview:imageView];
    }
    
    //設置初始滾動的位置為第二個view
    scrollView.contentOffset = CGPointMake(0, height);
}

- (void)setPageControl
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    pageControl = [[UIPageControl alloc] init];
    
    switch (self.scrollingDirection) {
        case HorizontalScrolling:
            pageControl.frame = CGRectMake(0, height - 30, width, 20);
            break;
            
        case VeritcalScrolling:
            pageControl.frame = CGRectMake(30, 0, 20, height);
            pageControl.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
            
        default:
            break;
    }
    
    pageControl.currentPage = 0;
    pageControl.numberOfPages = images.count - 2;
    [self addSubview:pageControl];
}

- (NSInteger)resetCurrentFirstPageIndex:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    CGFloat width = CGRectGetWidth(scrollView.frame);
    CGFloat height = CGRectGetHeight(scrollView.frame);
    
    switch (self.scrollingDirection) {
        case HorizontalScrolling:
            //當滾動到最後的時候
            if (point.x / width > 1) {
                if (currentFirstPageIndex < images.count - 3) {
                    currentFirstPageIndex += 1;
                }
                else {
                    currentFirstPageIndex = 0;
                }
            }
            //當滾動到最前的時候
            else if (point.x / width < 1) {
                if (currentFirstPageIndex == 0) {
                    currentFirstPageIndex = images.count - 3;
                }
                else {
                    currentFirstPageIndex -= 1;
                }
            }
            break;
            
        case VeritcalScrolling:
            //當滾動到最後的時候
            if (point.y / height > 1) {
                if (currentFirstPageIndex < images.count - 3) {
                    currentFirstPageIndex += 1;
                }
                else {
                    currentFirstPageIndex = 0;
                }
            }
            //當滾動到最前的時候
            else if (point.y / height < 1) {
                if (currentFirstPageIndex == 0) {
                    currentFirstPageIndex = images.count - 3;
                }
                else {
                    currentFirstPageIndex -= 1;
                }
            }
            break;
            
        default:
            break;
    }
    
    return currentFirstPageIndex;
}

- (void)resetCustomViews:(UIScrollView *)scrollView
{
    NSInteger i = currentFirstPageIndex;
    for (UIImageView *imageView in scrollView.subviews) {
        imageView.image = [images objectAtIndex:i];
        i++;
    }
}

#pragma mark - UIScrollViewDelegate

//當停止滾動時，重設scrollView的contentOffset
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //重置currentFirstPage
    [self resetCurrentFirstPageIndex:scrollView];
    
    //重新設置image
    [self resetCustomViews:scrollView];
    
    //設置初始滾動的位置為第二個view
    switch (self.scrollingDirection) {
        case HorizontalScrolling:
            [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:false];
            break;
            
        case VeritcalScrolling:
            [scrollView setContentOffset:CGPointMake(0, CGRectGetHeight(scrollView.frame)) animated:false];
            break;
            
        default:
            break;
    }
}

//一邊滾動一邊設置pageControl的currentPage
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_hasPageControl) {
        [pageControl setCurrentPage:currentFirstPageIndex];
    }
}

#pragma mark - BannerImageViewDelegate

- (void)imagePressed:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(bannerImageViewDidSelectImageAtIndex:)]) {
        [self.delegate bannerImageViewDidSelectImageAtIndex:currentFirstPageIndex];
    }
}

@end
