//
//  ViewController.m
//  RollViewDemo
//
//  Created by apple on 15/9/23.
//  Copyright © 2015年 xinle.hou. All rights reserved.
//

#import "ViewController.h"
#import <iCarousel.h>
#import "RollRotary.h"

@interface ViewController () //<iCarouselDataSource, iCarouselDelegate>
@property (strong, nonatomic) iCarousel *carousel;
@property (nonatomic, strong) NSArray *arrays;
@property (strong, nonatomic) UIPageControl *pageControl;
 @property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) RollRotary *roll;
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    //模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *s1 = @"http://img4.duitang.com/uploads/item/201409/07/20140907092042_nAGzk.thumb.700_0.jpeg";
        NSString *s2 = @"http://img5.duitang.com/uploads/item/201408/12/20140812170146_AGvzn.jpeg";
        NSString *s3 = @"http://img4q.duitang.com/uploads/item/201408/06/20140806174038_he5Fc.jpeg";
        
        
        NSArray *array = @[s1,s2,s3];
         _roll.dataArray  = array;
    });
   
    
    
    _roll = [[RollRotary alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
//    _roll.dataArray = @[@"0.jpg",@"1.jpg",@"2.jpg"];
   
    _roll.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    _roll.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
     _roll.rollView.backgroundColor = [UIColor redColor];
    
//    _roll.imageViewType = UIViewContentModeScaleAspectFill;

    
    [self.view addSubview:_roll.rollView];
    
    _roll.clickAction = ^(NSInteger index, NSArray *dataArray){
        NSLog(@"%zd",index);
    };
    
    

}






@end
