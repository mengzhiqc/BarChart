//
//  DBBarChartView.m
//  disc
//
//  Created by 孟 智 on 14-2-13.
//  Copyright (c) 2014年 孟 智. All rights reserved.
//

#import "DBBarChartView.h"
typedef NS_ENUM(NSInteger, LSBarChartOrientation) {
    LSBarChartOrientationUpright,
    LSBarChartOrientationCrossWide,
    
};


@interface DBBarChartView()
@property (nonatomic) NSArray *itemData;
@property (nonatomic) LSBarChartOrientation orientation;
@property (nonatomic,strong) NSMutableArray *positionInfo;

@property (nonatomic,strong) UIColor *barColor;
@property (nonatomic,strong) UIColor *labelColor;
@property (nonatomic,strong) UIColor *numberColor;
@property (nonatomic) CGFloat labelWidth;
@end

@implementation DBBarChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithData:(NSArray *)itemData frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.itemData = itemData;
        self.orientation = LSBarChartOrientationUpright; //default orientation
        self.barColor = [UIColor blackColor];
        self.labelColor = [UIColor blackColor];
        self.numberColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
        self.labelWidth = 30;
        
        
        
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

 - (void)drawRect:(CGRect)rect
{
    
    if ([self.delegate respondsToSelector:@selector(widthOfBarCharView:)]) {
        self.labelWidth = [self.delegate widthOfBarCharView:self];
        NSLog(@"number color change to :%@",self.numberColor);
    }
    
    if ([self.delegate respondsToSelector:@selector(barColorOfChartView:)]) {
        self.barColor = [self.delegate barColorOfChartView:self];
        NSLog(@"bar color change to :%@",self.barColor);
    }
    if ([self.delegate respondsToSelector:@selector(labelColorOfChartView:)]) {
        self.labelColor = [self.delegate labelColorOfChartView:self];
        NSLog(@"label color change to :%@",self.labelColor);
    }
    
    if ([self.delegate respondsToSelector:@selector(numberLabelcolorOfChartView:)]) {
        self.numberColor = [self.delegate numberLabelcolorOfChartView:self];
        NSLog(@"number color change to :%@",self.numberColor);
    }
    
    int itemCount = self.itemData.count;
    self.positionInfo = [[NSMutableArray alloc]init];
    
    if (itemCount > 0) {
        CGFloat intervalSpace = self.frame.size.height / (itemCount+1);
        
        CGFloat valueUnit = 0;
        for (NSDictionary *item in self.itemData) {
            if ([item[@"value"] floatValue]>valueUnit) {
                valueUnit = [item[@"value"] floatValue];
            }
        }
        
        valueUnit = (self.frame.size.width-10-self.labelWidth-30)/valueUnit;
        
        for (int i=0; i<itemCount; i++) {
            NSDictionary *item = self.itemData[i];
            
            CGRect labelFrame = CGRectMake(10,(i+1)*intervalSpace, self.labelWidth, 30);
            CGRect barFrame = CGRectMake(10+self.labelWidth+10, (i+1)*intervalSpace, [item[@"value"] floatValue]*valueUnit, 30);
            NSLog(@"barFrame:%.2f,%.2f",labelFrame.origin.x,labelFrame.origin.y);
            [self.positionInfo addObject:@{@"labelFrame":[NSValue valueWithCGRect:labelFrame],
                                           @"barFrame":[NSValue valueWithCGRect:barFrame]}];
        }
    }
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 3.0);
    
    

    CGContextSetStrokeColorWithColor(context, self.barColor.CGColor);
    CGContextBeginPath(context);
    for (int i=0; i<self.positionInfo.count; i++) {
        
        NSValue *barFrameValue = (NSValue *)self.positionInfo[i][@"barFrame"];
        CGRect barFrame = barFrameValue.CGRectValue;
        
        NSValue *labelFrameValue = (NSValue *)self.positionInfo[i][@"labelFrame"];
        CGRect labelFrame = labelFrameValue.CGRectValue;
        NSLog(@"barFrame:%.2f,%.2f",labelFrame.origin.x,labelFrame.origin.y);

        CGContextMoveToPoint(context, barFrame.origin.x, barFrame.origin.y);
        CGContextAddLineToPoint(context, barFrame.origin.x+barFrame.size.width, barFrame.origin.y);
        CGContextStrokePath(context);

        CGContextSaveGState(context);
        CGContextSetTextDrawingMode(context, kCGTextFill);

        [self.itemData[i][@"value"] drawAtPoint:CGPointMake(barFrame.origin.x+barFrame.size.width+10, barFrame.origin.y-8) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:12],
                                                                                                                                            NSForegroundColorAttributeName:self.numberColor
                                                                                                                                            }];
        NSLog(@"self.numColor:%@",self.numberColor);
        [self.labelColor setFill];
        CGContextSetFillColorWithColor(context, self.labelColor.CGColor);

        [self.itemData[i][@"itemName"] drawAtPoint:CGPointMake(labelFrame.origin.x, labelFrame.origin.y-10) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:15],
                                                                                                                             NSForegroundColorAttributeName:self.labelColor
                                                                                                                             }];
        CGContextRestoreGState(context);

    
    }
    
}


@end
