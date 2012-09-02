//
//  BDBowlingGameScoreTests.m
//  Kata 2 Bowling
//
//  Created by Tim Taylor on 9/2/12.
//  Copyright (c) 2012 Tim Taylor. All rights reserved.
//

#import "BDBowlingGameScoreTests.h"

@implementation BDBowlingGameScoreTests

-(void)setUp{
    bowlingGame=[[BDBowlingGame alloc] init];
}

-(void)tearDown{
    bowlingGame = nil;
}

-(void)testThatClassExists{
    BDBowlingGame *newBowlingGame=[[BDBowlingGame alloc] init];
    STAssertNotNil(newBowlingGame,@"BDBowlingGame should return non nil when alloc/initing");
}

-(void)testThatClassHasRollMethod{
    STAssertTrue([bowlingGame respondsToSelector:@selector(roll:)], @"BDBowlingGame should have a roll: method");
}

-(void)testThatClassHasScoreMethod{
    STAssertTrue([bowlingGame respondsToSelector:@selector(score)], @"BDBowlingGame should have a score method");
}

-(void)testThatClassScoresGutterGameCorrectly{
    [self rollManyTimes:20 pins:0];
    NSInteger expectedScore=0l;
    NSInteger actualScore=bowlingGame.score;
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame gutter game should be scored correctly.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
}

-(void)testThatClassScoresSinglePinPerRollCorrectly{
    [self rollManyTimes:20 pins:1];
    NSInteger expectedScore=20l;
    NSInteger actualScore=bowlingGame.score;
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame single pin per roll should be scored correctly.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
}

-(void)rollManyTimes:(NSInteger)rolls pins:(NSInteger)pins{
    for (NSInteger iCntr=0; iCntr<rolls; iCntr++) {
        [bowlingGame roll:pins];
    }
}

@end
