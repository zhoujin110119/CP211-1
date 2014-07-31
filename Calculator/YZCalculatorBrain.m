//
//  YZCalculatorBrain.m
//  Calculator
//
//  Created by apple on 14-7-27.
//  Copyright (c) 2014年 zhoujin. All rights reserved.
//

#import "YZCalculatorBrain.h"

@implementation YZCalculatorBrain

- (void)setOperand:(double)value{
    operand = value;
}

- (void) performWaitingOperator{
    if ([@"+" isEqualToString:waitingOperator])
    {
        operand = waitingOperand + operand;
    }
    else if ([@"-" isEqualToString:waitingOperator])
    {
        operand = waitingOperand - operand;
    }
    else if ([@"*" isEqualToString:waitingOperator])
    {
        operand = waitingOperand * operand;
    }
    else if ([@"/" isEqualToString:waitingOperator])
    {
        operand = waitingOperand / operand;
    }
}

- (double)performOperator:(NSString *)operator{
    if ([operator isEqualToString:@"sqrt"]) {
        operand = sqrt(operand);
    } else {
        [self performWaitingOperator];
        waitingOperator = operator;
        waitingOperand = operand;
    }
    
    return operand;
}

-(void)cleanWaitingOperator
{
    waitingOperator = nil;
}

- (double)performSingleOperator:(NSString *)operator{
    if ([operator isEqualToString:@"sqrt"]) {
        operand = sqrt(operand);
    }
    else if ([operator isEqualToString:@"-/+"])
    {
        operand = - operand;
    }
    else if ([operator isEqualToString:@"C"])
    {
        operand = 0;
    }
    
    return operand;
}
@end
