//
//  YZCalculatorBrain.h
//  Calculator
//
//  Created by apple on 14-7-27.
//  Copyright (c) 2014年 zhoujin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZCalculatorBrain : NSObject{
    double operand;
    double waitingOperand;
    NSString * waitingOperator;
}

- (void)setOperand:(double)value;
- (double)performOperator:(NSString *)operator;
- (void)cleanWaitingOperator;
- (double)performSingleOperator:(NSString *)operator;



@end
