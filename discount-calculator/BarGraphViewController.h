//
//  BarGraphView.h
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/27/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarGraphViewController : UIViewController

@property(strong, nonatomic) NSDecimalNumber * finalPrice;
@property(strong, nonatomic) NSDecimalNumber * originalPrice;

@end