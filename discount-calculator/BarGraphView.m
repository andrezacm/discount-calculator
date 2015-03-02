//
//  BarGraphView.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/28/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BarGraphView.h"

@implementation BarGraphView

  @synthesize discountPrice;
  @synthesize savedValue;

-(id)initWithFrame:(CGRect)frame {
  NSLog(@"initWithFrame");
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
  NSLog(@"initWithCoder");
  self = [super initWithCoder:aDecoder];
  if (self) {
    // Initialization code
  }
  return self;
}

-(void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  //set colors
  CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
  CGContextSetLineWidth(context, 2.0);
  
  CGRect priceRect = CGRectMake(40, 100, 100, 300);
  //price
  CGContextStrokeRect(context, priceRect);
  
  //price - discount price
  CGContextStrokeRect(context, CGRectMake(180, 100, 100, 90));
  
  //discount price
  CGContextStrokeRect(context, CGRectMake(180, 200, 100, 200));
  
  NSString * s = [@"opa " stringByAppendingString:[discountPrice stringValue]];
  NSDictionary * textAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Arial" size:18]};
  CGSize size = [s sizeWithAttributes:textAttributes];
  
  CGRect textRect = CGRectMake((priceRect.origin.x + 4),
                                priceRect.origin.y + (priceRect.size.height - size.height)/2,
                                priceRect.size.width,
                                (priceRect.size.height - size.height)/2);

  [s drawInRect:textRect withAttributes:textAttributes];
}

@end