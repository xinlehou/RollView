//
//  RollRotaryView.h
//  RollViewDemo
//
//  Created by apple on 15/9/23.
//  Copyright © 2015年 xinle.hou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>


@interface RollRotary : NSObject



- (instancetype)initWithFrame:(CGRect )frame;

/** 视图  */
@property (nonatomic, strong) UIView *rollView;

/** 数据数组 
    可存放本地图片名称
    网络图片地址
 */
@property (nonatomic, strong) NSArray *dataArray;

@property (strong, nonatomic) UIPageControl *pageControl;

/** 类型设置  默认类型：iCarouselTypeRotary */
@property (nonatomic, assign) iCarouselType type;


@property (nonatomic, assign) UIViewContentMode imageViewType;

@property (nonatomic, assign) CGSize imageViewSize;


/** 点击事件 会返回点击的index  和 数据数组 */
@property (nonatomic, copy) void (^clickAction)(NSInteger index, NSArray *dataArray);

@end
