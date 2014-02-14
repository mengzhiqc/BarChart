//
//  DBBarChartView.h
//  disc
//
//  Created by 孟 智 on 14-2-13.
//  Copyright (c) 2014年 孟 智. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DBBarChartView;

@protocol BarChartViewDelegate <NSObject>

@optional
- (UIColor *)barColorOfChartView:(DBBarChartView *)barChartView ;
- (UIColor *)labelColorOfChartView:(DBBarChartView *)barChartView ;
- (UIColor *)numberLabelcolorOfChartView:(DBBarChartView *)barChartView ;
- (CGFloat)widthOfBarCharView:(DBBarChartView *)charView;

@end

@interface DBBarChartView : UIView

@property (nonatomic, weak) id<BarChartViewDelegate> delegate;

- (id)initWithData:(NSArray *)itemData frame:(CGRect)frame;
@end
