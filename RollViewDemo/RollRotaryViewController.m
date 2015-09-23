//
//  RollRotaryViewController.m
//  RollViewDemo
//
//  Created by apple on 15/9/23.
//  Copyright © 2015年 xinle.hou. All rights reserved.
//

#import "RollRotaryViewController.h"



@interface RollRotaryViewController ()


@end

@implementation RollRotaryViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
    self.carousel.backgroundColor = [UIColor redColor];
    self.carousel.delegate = self;
    self.carousel.dataSource = self;
    self.carousel.type = iCarouselTypeRotary;
    self.carousel.scrollSpeed = 6;
    self.carousel.pagingEnabled = YES;
    [self.view addSubview:self.carousel];
//    _dataArray = @[@"1.jpg",@"2.jpg",@"3.jpg"];
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.numberOfPages = _dataArray.count;
    self.view.backgroundColor = [UIColor grayColor];
//    self.pageControl.center = self.view.center;
    [self.view addSubview:self.pageControl];
    
    
    [self addTimer];
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 200.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd.jpg",index]];
        view = imageView;
        //        view.backgroundColor = [UIColor orangeColor];
    }
    
    
    return view;
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    NSLog(@"点击了%zd",index);
}

-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    //添加到runloop中
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
}


- (void)nextImage
{
    
    NSInteger index = self.carousel.currentItemIndex + 1;
    if (index == _dataArray.count ) {
        index = 0;
    }
    
    [self.carousel scrollToItemAtIndex:index animated:YES];
    
    
}

- (void)carouselDidScroll:(iCarousel *)carousel;
{
    self.pageControl.currentPage = carousel.currentItemIndex;
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    [self removeTimer];
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate{
    //    开启定时器
    [self addTimer];
}

@end
