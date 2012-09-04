//
//  BDBowlingGame.h
//  Kata 2 Bowling
//
//  Created by Tim Taylor on 9/2/12.
//  Copyright (c) 2012 Tim Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBowlingGame : NSObject{
    NSInteger rolls[22];
    NSInteger currentRoll;
    NSInteger sum;
}

-(void)roll:(NSInteger)pins;
-(NSInteger)score;
-(NSInteger)scoreForFrame:(NSInteger)frame;

@end
