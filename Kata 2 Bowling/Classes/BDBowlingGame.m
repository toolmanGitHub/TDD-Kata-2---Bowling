//
//  BDBowlingGame.m
//  Kata 2 Bowling
//
//  Created by Tim Taylor on 9/2/12.
//  Copyright (c) 2012 Tim Taylor. All rights reserved.
//

#import "BDBowlingGame.h"

@implementation BDBowlingGame



-(void)roll:(NSInteger)pins{
    rolls[currentRoll]=pins;
    currentRoll++;
    
}

-(NSInteger)score{
    sum=0;
    for (NSInteger iCntr=0; iCntr<=currentRoll; iCntr++) {
        sum+=rolls[iCntr];
    }
    
    return sum;
}



@end
