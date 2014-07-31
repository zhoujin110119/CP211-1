//
//  YZViewController.m
//  Calculator
//
//  Created by apple on 14-7-27.
//  Copyright (c) 2014年 zhoujin. All rights reserved.
//

#import "YZViewController.h"

#import "YZCalculatorBrain.h"

@interface YZViewController ()
{
    YZCalculatorBrain * _brain;
    
    bool userIsTypingNumber;
    bool userIsTypingEqual;
}

@property (weak, nonatomic) IBOutlet UILabel *display;


- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operatorPressed:(UIButton *)sender;
- (IBAction)singleoperatorPressed:(UIButton *)sender;
- (IBAction)CEPressed:(UIButton *)sender;
- (IBAction)DelPressed:(UIButton *)sender;

@end

@implementation YZViewController

- (YZCalculatorBrain *) brain
{
    if (!_brain) _brain = [[YZCalculatorBrain alloc] init];
    
    return _brain;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    userIsTypingNumber = NO;
    userIsTypingEqual = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSLog(@"Digit %@ pressed.", [[sender titleLabel] text]);
    
    NSString *digit = [[sender titleLabel] text];
    if (userIsTypingNumber && !userIsTypingEqual)
    {
        [_display setText:[[_display text] stringByAppendingString:digit]];
    }
    else
    {
        [_display setText:digit];
        userIsTypingNumber = YES;
    }
    userIsTypingEqual = NO;
}

- (IBAction)operatorPressed:(UIButton *)sender {
    NSLog(@"Operator %@ pressed.", [[sender titleLabel] text]);
    
    NSString * operator = [[sender titleLabel]text];
    if (userIsTypingNumber || userIsTypingEqual) {
        [[self brain] setOperand:[[_display text] doubleValue]];
        
        if ([operator isEqualToString:@"="])
        {
            userIsTypingEqual = YES;
        }
        else
        {
            userIsTypingEqual = NO;
        }
        
        userIsTypingNumber = NO;
    }
    else {
        //NSLog(@"ERROR! Double operator!");
        [[self brain] cleanWaitingOperator];
        
        //return;
    }
    
    double result = [[self brain] performOperator:operator];
    [_display setText:[NSString stringWithFormat:@"%g",result]];
}

- (IBAction)singleoperatorPressed:(UIButton *)sender {
    NSLog(@"Operator %@ pressed.", [[sender titleLabel] text]);
    [[self brain] setOperand:[[_display text] doubleValue]];
    NSString * operator = [[sender titleLabel]text];
    
    
    
    if ([operator isEqualToString:@"-/+"])
    {
        userIsTypingNumber = YES;
    }
    else
    {
        userIsTypingNumber = NO;
    }
    
    
    
    double result = [[self brain] performSingleOperator:operator];
    [_display setText:[NSString stringWithFormat:@"%g",result]];
}

- (IBAction)CEPressed:(UIButton *)sender {
    userIsTypingEqual = NO;
    userIsTypingNumber = NO;
    [[self brain] cleanWaitingOperator];
    [_display setText:[NSString stringWithFormat:@"%g",0.0]];
}

- (IBAction)DelPressed:(UIButton *)sender {
    NSLog(@"Del pressed.");
    
    if (userIsTypingNumber )
    {
        [_display setText:[[_display text] substringToIndex:[_display text].length-1]];
        if ([_display text].length == 0)
        {
            [_display setText:@"0"];
            userIsTypingNumber = NO;
        }
    }

}

@end
