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



-(void)testThatClassScoresASpareCorrectly_One{
    [self rollSpareWithFirstRoll:5 secondRoll:5];
    
    [bowlingGame roll: 3]; // First ball of next frame is bonus for the spare in the previous frame!
    
    [self rollManyTimes:17 pins:0];
    NSInteger expectedScore=(5+5+3 +3);
    NSInteger actualScore=bowlingGame.score;
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame bowling a spare should score correctly.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
    
}

-(void)testThatClassScoresASpareCorrectly_Two{
    [self bowlFrameWithFirstRoll:5 secondRoll:4];
    [self rollSpareWithFirstRoll:3 secondRoll:7];
    [bowlingGame roll: 2];
    
    [self rollManyTimes:15 pins:0];
    NSInteger expectedScore=(5+4+3+7+2 +2);
    NSInteger actualScore=bowlingGame.score;
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame bowling a spare should score correctly, test two.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
    
}

-(void)testThatClassScoresAStrikeCorrectly{
    [bowlingGame roll: 10];  // A strike
    [self bowlFrameWithFirstRoll:5 secondRoll:2];
    [self rollManyTimes:15  pins:0];
    
    NSInteger expectedScore=(10+5+2 +5+2);
    NSInteger actualScore=bowlingGame.score;
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame bowling a strike should score correctly.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
}

-(void)testThatClassScoresAPerfectGameCorrectly{
    [self rollManyTimes:12 pins:10];
    NSInteger expectedScore=300;
    NSInteger actualScore=bowlingGame.score;
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame bowling a perfect game should score correctly.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
}

-(void)testThatClassScoresANotQuitePerfectGame{
    [self rollManyTimes:10 pins:10];
    
    [self bowlFrameWithFirstRoll:5 secondRoll:5];
    NSInteger expectedScore=285;
    NSInteger actualScore=bowlingGame.score;
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame bowling a perfect game should score correctly.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
}

-(void)testThatClassScoresANotQuitePerfectGame_Two{
    [self rollManyTimes:9 pins:10];
    
    [bowlingGame roll:5];
    [bowlingGame roll:5]; // Spare in Final Frame
    [bowlingGame roll:10]; // Strike for third roll of final frame
    NSInteger expectedScore=275;
    NSInteger actualScore=bowlingGame.score;
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame bowling a perfect game should score correctly.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
}

-(void)testThatClassScoresUncleBobsCorrectly{
    [self bowlFrameWithFirstRoll:1 secondRoll:4];
    [self bowlFrameWithFirstRoll:4 secondRoll:5];
    [self rollSpareWithFirstRoll:6 secondRoll:4];
    [self rollSpareWithFirstRoll:5 secondRoll:5];
    [bowlingGame roll:10]; // strike in fifth frame
    [self bowlFrameWithFirstRoll:0 secondRoll:1];
    [self bowlFrameWithFirstRoll:7 secondRoll:3];
    [self bowlFrameWithFirstRoll:6 secondRoll:4];
    [bowlingGame roll:10];  // strike in ninth frame
    [self rollSpareWithFirstRoll:2 secondRoll:8];
    [bowlingGame roll:6];
    
    NSInteger expectedScore=133;
    NSInteger actualScore=bowlingGame.score;
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame Uncle Bob's game should score correctly.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
}

-(void)testThatClassRespondsToGettingScoreMidGame{
    STAssertTrue([bowlingGame respondsToSelector:@selector(scoreForFrame:)], @"BDBowlingGame should respond to scoreForFrame: method");
}

-(void)testThatClassScoresCorrectlyMidGame_Spare{
    [self bowlFrameWithFirstRoll:1 secondRoll:4];
    [self bowlFrameWithFirstRoll:4 secondRoll:5]; //14
    [self rollSpareWithFirstRoll:6 secondRoll:4]; // 29
    [self rollSpareWithFirstRoll:5 secondRoll:5];
    
    NSInteger expectedScore=29;
    NSInteger actualScore=[bowlingGame scoreForFrame:3];
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame should score correctly mid game.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
}

-(void)testThatClassScoresCorrectlyMidGame_Strike{
    [self bowlFrameWithFirstRoll:1 secondRoll:4];
    [self bowlFrameWithFirstRoll:4 secondRoll:5];
    [self rollSpareWithFirstRoll:6 secondRoll:4];  //29
    [self rollSpareWithFirstRoll:5 secondRoll:5];  // 49
    [bowlingGame roll:10]; // strike in fifth frame //60
    [self bowlFrameWithFirstRoll:0 secondRoll:1];
    
    NSInteger expectedScore=60;
    NSInteger actualScore=[bowlingGame scoreForFrame:5];
    STAssertEquals(expectedScore, actualScore, @"BDBowlingGame should score correctly mid game, strike.  Expected:  %ld.  Got:  %ld",expectedScore,actualScore);
}
#pragma mark -
#pragma mark Helpers

-(void)bowlFrameWithFirstRoll:(NSInteger)rollOne secondRoll:(NSInteger)rollTwo{
    [bowlingGame roll:rollOne];
    [bowlingGame roll:rollTwo];
}

-(void)rollManyTimes:(NSInteger)rolls pins:(NSInteger)pins{
    for (NSInteger iCntr=0; iCntr<rolls; iCntr++) {
        [bowlingGame roll:pins];
    }
}

-(void)rollSpareWithFirstRoll:(NSInteger)rollOnePins secondRoll:(NSInteger)rollTwoPins{
    [bowlingGame roll: rollOnePins];
    [bowlingGame roll: rollTwoPins];
}

@end
