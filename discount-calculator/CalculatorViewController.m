//
//  CalculatorView.m
//  discount-calculator
//
//  Created by Andreza da Costa Medeiros on 2/27/15.
//  Copyright (c) 2015 Andreza da Costa Medeiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorViewController.h"
#import "BarGraphViewController.h"

@implementation CalculatorViewController

  @synthesize calculator;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  calculator = [Calculator initialize];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                        selector:@selector(keyboardDidShow:)
                                        name:UIKeyboardDidShowNotification
                                        object:nil];
  
  [self.price setDelegate:self];
  [self.dollarsOff setDelegate:self];
  [self.discount setDelegate:self];
  [self.discountAdd setDelegate:self];
  [self.tax setDelegate:self];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

// Dismiss keyboard by touching outside
- (void) touchesBegan:(NSSet * )touches withEvent:(UIEvent * )event {
  [[self view] endEditing:YES];
}

- (void) keyboardDidShow:(NSNotification *)notification {
  //set scroll view
  UIScrollView * tempScrollView = (UIScrollView *)self.view;
  tempScrollView.contentSize = CGSizeMake(250, 750);
}

- (IBAction)doneClicked:(id)sender {
  NSLog(@"Done Clicked.");
  [sender resignFirstResponder];
  [self.view endEditing:YES];
}

- (void)nextClicked: (UIBarButtonItem*) sender {
  NSArray * textFields = [NSArray arrayWithObjects:self.price, self.dollarsOff, self.discount, self.discountAdd, self.tax, nil];
  
  NSInteger nextTag = (sender.tag + 1)%5;

  [textFields[nextTag] becomeFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  [textField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  NSLog(@">>>>OPA");
  UIToolbar * keyboardCustomizedView = [[UIToolbar alloc] init];
  [keyboardCustomizedView sizeToFit];
  
  UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                  style:UIBarButtonItemStyleBordered target:self
                                                                 action:@selector(doneClicked:)];
  UIBarButtonItem * nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                  style:UIBarButtonItemStyleBordered target:self
                                                                 action:@selector(nextClicked:)];
  UIBarButtonItem * prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Prev"
                                                                  style:UIBarButtonItemStyleBordered target:self
                                                                 action:@selector(doneClicked:)];
  
  [keyboardCustomizedView setItems:[NSArray arrayWithObjects:doneButton, nextButton, prevButton, nil]];
  [textField setInputAccessoryView:keyboardCustomizedView];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  // Get the new view controller using [segue destinationViewController].
  // Pass the selected object to the new view controller.
  BarGraphViewController * barGVC = (BarGraphViewController *)segue.destinationViewController;
  barGVC.discount = calculator.discountPrice;
  barGVC.originalPrice = calculator.originalPrice;
}

- (IBAction)calculateDiscount:(id)sender {
  //Dismiss keyboard
  [[self view] endEditing:YES];
  
  [calculator setPrice:[NSDecimalNumber decimalNumberWithString:_price.text]];
  [calculator setDollarsOff:[NSDecimalNumber decimalNumberWithString:_dollarsOff.text]];
  [calculator setDiscount:[NSDecimalNumber decimalNumberWithString:_discount.text]];
  [calculator setDiscountAdd:[NSDecimalNumber decimalNumberWithString:_discountAdd.text]];
  [calculator setTax:[NSDecimalNumber decimalNumberWithString:_tax.text]];
  
  [calculator calculateOriginalPrice];
  [calculator calculateFinalPrice];
  
  _originalPrice.text = [@"Original Price: $" stringByAppendingString:[calculator.originalPrice stringValue]];
  _discountPrice.text = [@"Discount Price: $" stringByAppendingString:[calculator.discountPrice stringValue]];
  _finalPrice.text = [@"Final Price (with tax): $" stringByAppendingString:[calculator.finalPrice stringValue]];
}

@end