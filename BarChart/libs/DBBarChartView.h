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
- (UIColor *)colorOfGraphicBarWithbarChartView:(DBBarChartView *)barChartView ;
- (UIColor *)colorOfDataLabelWithbarChartView:(DBBarChartView *)barChartView ;
- (UIColor *)colorOfDataNumWithbarChartView:(DBBarChartView *)barChartView ;
- (CGFloat)widthOfBarCharView:(DBBarChartView *)charView;

@end

@interface DBBarChartView : UIView

@property (nonatomic, weak) id<BarChartViewDelegate> delegate;

- (id)initWithData:(NSArray *)itemData frame:(CGRect)frame;
@end
