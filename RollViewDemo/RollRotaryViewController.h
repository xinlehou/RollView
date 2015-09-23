//
//  RollRotaryViewController.h
//  RollViewDemo
//
//  Created by apple on 15/9/23.
//  Copyright © 2015年 xinle.hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>
@interface RollRotaryViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic) iCarousel *carousel;
@property (nonatomic, strong) NSArray *dataArray;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;






@end
