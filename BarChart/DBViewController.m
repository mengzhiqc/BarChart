//
//  DBViewController.m
//  BarChart
//
//  Created by 孟 智 on 14-2-13.
//  Copyright (c) 2014年 Lenye Studio. All rights reserved.
//

#import "DBViewController.h"

@interface DBViewController ()

@end

@implementation DBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *itemData = @[
                          @{@"itemName":@"Flower",@"value":@"5"},
                          @{@"itemName":@"Book",@"value":@"6"},
                          @{@"itemName":@"Bus",@"value":@"8"},
                          @{@"itemName":@"Others",@"value":@"2"},
                          ];
    DBBarChartView *barChartView = [[DBBarChartView alloc]initWithData:itemData frame:CGRectMake(0, 20, 280, 100)];
    barChartView.delegate = self;
    
    [self.view addSubview:barChartView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *)barColorOfChartView:(DBBarChartView *)barChartView
{
    return [UIColor blackColor];
}

- (UIColor *)numberLabelcolorOfChartView:(DBBarChartView *)barChartView
{
    return [UIColor colorWithRed:0.6 green:0 blue:0.6 alpha:1.0];
}

- (UIColor *)labelColorOfChartView:(DBBarChartView *)barChartView
{
    return [UIColor grayColor];
}

- (CGFloat)widthOfBarCharView:(DBBarChartView *)barCharView
{
    return 50.0f;
}

@end
