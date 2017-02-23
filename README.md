# BannerImageView
`BannerImageView` is a clean and easy-to-use image banner on iOS.

## How To Use
Just import the header file and create an instance of `BannerImageView`.
```objective-c
#import "BannerImageView.h"

...

BannerImageView *bannerImageView = [[BannerImageView alloc] initWithFrame:rect 
                                                               imageNames:images 
                                                       scrollingDirection:HorizontalScrolling];
bannerImageView.contentMode = UIViewContentModeScaleAspectFit;
bannerImageView.hasPageControl = true;
bannerImageView.delegate = self;
[self.view addSubview:bannerImageView];
```

### Gesture Interaction

```objective-c
- (void)bannerImageViewDidSelectImageAtIndex:(NSInteger)index;
```
