//
//  ViewController.m
//  BannerImageView
//
//  Created by Yuchi Chen on 2017/2/23.
//  Copyright © 2017年 Yuchi Chen. All rights reserved.
//

#import "ViewController.h"
#import "BannerImageView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController () <BannerImageViewDelegate>

@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //store image name in images
    NSMutableArray *images = [NSMutableArray arrayWithArray:@[@"image0.jpg", @"image1.jpg", @"image2.jpg", @"image3.jpg"]];
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    CGRect rect = CGRectMake((SCREEN_WIDTH / 2) - (width / 2), (SCREEN_HEIGHT / 2) - (height / 2), width, height);
    
    BannerImageView *bannerImageView = [[BannerImageView alloc] initWithFrame:rect imageNames:images scrollingDirection:HorizontalScrolling];
    bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
    bannerImageView.hasPageControl = true;
    bannerImageView.delegate = self;
    [self.view addSubview:bannerImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - BannerScrollViewDelegate

- (void)bannerImageViewDidSelectImageAtIndex:(NSInteger)index
{
    NSLog(@"%ld", (long)index);
}

@end
