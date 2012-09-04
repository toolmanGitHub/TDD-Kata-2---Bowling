//
//  BDBowlingGame.m
//  Kata 2 Bowling
//
//  Created by Tim Taylor on 9/2/12.
//  Copyright (c) 2012 Tim Taylor. All rights reserved.
//

#import "BDBowlingGame.h"

@implementation BDBowlingGame

-(id)init{
    self= [super init];
    if (self) {
        currentRoll=0;
    }
    return self;
}



-(void)roll:(NSInteger)pins{
    rolls[currentRoll]=pins;
    currentRoll++;
    
}

-(NSInteger)score{
        
    return [self scoreForFrame:10];
}

-(NSInteger)scoreForFrame:(NSInteger)frame{
    sum=0;
    NSInteger currentFrame=0;
    NSInteger roll=0;
    for (currentFrame=0 ; currentFrame<frame; currentFrame++) {
        if ([self isStrikeForRoll:roll]) {
            sum+=10+[self strikeBonusForRoll:roll];
            roll++;
        }else{
            if ([self isSpareForRoll:roll]) {
                sum+=10l+[self spareBonusForRoll:roll];
            }else{
                sum+=[self frameTotalForRoll:roll];
            }
            roll+=2;
        }
    }
    
    return sum;

    
}

-(NSInteger)frameTotalForRoll:(NSInteger)roll{
    return rolls[roll]+rolls[roll+1];
}

-(BOOL)isSpareForRoll:(NSInteger)roll{
    NSInteger pinsRollOne=rolls[roll];
    NSInteger pinsRollTwo=rolls[roll+1];
    
    if (pinsRollOne+pinsRollTwo==10)
        return YES;
    return NO;
}

-(NSInteger)spareBonusForRoll:(NSInteger)roll{
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
