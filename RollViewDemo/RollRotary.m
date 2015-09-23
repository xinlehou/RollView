//
//  RollRotaryView.m
//  RollViewDemo
//
//  Created by apple on 15/9/23.
//  Copyright © 2015年 xinle.hou. All rights reserved.
//

#import "RollRotary.h"
#import "RollRotaryViewController.h"
#import <UIImageView+WebCache.h>

#define RollW [UIScreen mainScreen].bounds.size.width

@interface RollRotary () <iCarouselDataSource, iCarouselDelegate>


@property (strong, nonatomic) iCarousel *carousel;

@property (nonatomic, strong) NSTimer *timer;


@end


@implementation RollRotary


- (instancetype)initWithFrame:(CGRect )frame{
    if (self = [super init]) {
        
        
        _rollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,RollW, 200)];
        self.rollView.frame = frame;
        self.carousel.frame = self.rollView.bounds;
       
        
        self.carousel = [[iCarousel alloc] initWithFrame:_rollView.bounds];
        
        self.carousel.delegate = self;
        self.carousel.dataSource = self;
        self.type = iCarouselTypeRotary;
        self.carousel.scrollSpeed = 6;
        self.carousel.pagingEnabled = YES;
        
        [_rollView addSubview:self.carousel];
        
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.numberOfPages = _dataArray.count;
        
        self.pageControl.center = CGPointMake(_rollView.center.x, _rollView.frame.size.height - 10);
        

        self.imageViewType = UIViewContentModeScaleAspectFit;
        
        self.imageViewSize = CGSizeMake(300, 200);
        
        [_rollView addSubview:self.pageControl];
        
        
        [self addTimer];

    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    
    self.pageControl.numberOfPages = dataArray.count;
    
    //如果是网络的地址 就缓存
//    if([dataArray.firstObject hasPrefix:@"htttp"]){
//        [dataArray writeToFile:nil atomically:YES];
//        
//    }
    
    [self.carousel reloadData];
}

- (void)setType:(iCarouselType)type{
    _type = type;
    
    self.carousel.type = type;
    
}

#pragma mark -- 私有
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    
    return _dataArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageViewSize.width, self.imageViewSize.height)];
        imageView.contentMode = self.imageViewType;
       
        NSString *str = _dataArray[index];
        
        if ([str hasPrefix:@"http"]) {
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"load.jpg"]];
            
        }else{
            
            imageView.image = [UIImage imageNamed:str];
        }
        
    
        view = imageView;
        //        view.backgroundColor = [UIColor orangeColor];
    }
    
    
    return view;
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
   
    if (self.clickAction) {
        self.clickAction(index,self.dataArray);
    }
}

-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                  target:self
                                                selector:@selector(nextImage)
                                                userInfo:nil
                                                 repeats:YES];
    //添加到runloop中
    [[NSRunLoop mainRunLoop]addTimer:self.timer
                             forMode:NSRunLoopCommonModes];
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
    
    [self.carousel scrollToItemAtIndex:index
                              animated:YES];
    
    
}

- (void)carouselDidScroll:(iCarousel *)carousel;
{
    self.pageControl.currentPage = carousel.currentItemIndex;
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    [self removeTimer];
}

- (void)carouselDidEndDragging:(iCarousel *)carousel
                willDecelerate:(BOOL)decelerate{
    //    开启定时器
    [self addTimer];
}

@end
