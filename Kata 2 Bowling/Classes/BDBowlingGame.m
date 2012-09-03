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
    NSInteger currentFrame=0;
    NSInteger roll=0;
    for (currentFrame=0 ; currentFrame<10; currentFrame++) {
        if ([self isStrikeForRoll:roll]) {
            sum+=10+[self strikeBonusForRoll:roll];
            roll++;
        }else{
            if ([self isSpareForRoll:roll]) {
                NSLog(@"  isSpare");
                sum+=10l+[self spareBonusForRoll:roll];
            }else{
                sum+=rolls[roll]+rolls[roll+1];
            }
            
            roll+=2;
        }
        NSLog(@"frame:  %ld, score=%ld",currentFrame,sum);
        
    }
    
    return sum;
}

-(BOOL)isSpareForRoll:(NSInteger)roll{
    NSInteger pinsRollOne=rolls[roll];
    NSInteger pinsRollTwo=rolls[roll+1];
    
    if (pinsRollOne+pinsRollTwo==10)
        return YES;
    return NO;
}

-(NSInteger)spareBonusForRoll:(NSInteger)roll{
    NSLog(@"   spare bonus=%ld",rolls[roll+2]);
    return rolls[roll+2];
    
}

-(BOOL)isStrikeForRoll:(NSInteger)roll{

    if (rolls[roll]==10) {
        return YES;
    }
    return NO;
}

-(NSInteger)strikeBonusForRoll:(NSInteger)roll{
    NSInteger nextRoll=roll+1;
    return rolls[nextRoll]+rolls[nextRoll+1];
    
}



@end
