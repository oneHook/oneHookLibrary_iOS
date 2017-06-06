//
//  OHTimerLabel.h
//  oneHookLibrary
//
//  Created by EagleDiao@Optimity on 2017-06-06.
//  Copyright © 2017 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**********************************************
 OHTimerLabel TimerType Enum
 **********************************************/
typedef enum{
    OHTimerLabelTypeStopWatch,
    OHTimerLabelTypeTimer
} OHTimerLabelType;

/**********************************************
 Delegate Methods
 @optional
 
 - timerLabel:finshedCountDownTimerWithTimeWithTime:
 ** MZTimerLabel Delegate method for finish of countdown timer
 
 - timerLabel:countingTo:timertype:
 ** MZTimerLabel Delegate method for monitering the current counting progress
 
 - timerlabel:customTextToDisplayAtTime:
 ** MZTimerLabel Delegate method for overriding the text displaying at the time, implement this for your very custom display formmat
 **********************************************/

@class OHTimerLabel;
@protocol OHTimerLabelDelegate <NSObject>
@optional
-(void)timerLabel:(OHTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime;
-(void)timerLabel:(OHTimerLabel*)timerLabel countingTo:(NSTimeInterval)time timertype:(OHTimerLabelType)timerType;
-(NSString*)timerLabel:(OHTimerLabel*)timerLabel customTextToDisplayAtTime:(NSTimeInterval)time;
@end


@interface OHTimerLabel : UILabel


/*Delegate for finish of countdown timer */
@property (nonatomic, weak) id<OHTimerLabelDelegate> delegate;

/*Target label obejct, default self if you do not initWithLabel nor set*/
@property (nonatomic,strong) UILabel *timeLabel;

/*Type to choose from stopwatch or timer*/
@property (assign) OHTimerLabelType timerType;

/*is The Timer Running?*/
@property (assign,readonly) BOOL counting;

/*do you reset the Timer after countdown?*/
@property (assign) BOOL resetTimerAfterFinish;


/*--------Init methods to choose*/
-(id)initWithTimerType:(OHTimerLabelType)theType;
-(id)initWithLabel:(UILabel*)theLabel andTimerType:(OHTimerLabelType)theType;
-(id)initWithLabel:(UILabel*)theLabel;


/*--------Timer control methods to use*/
-(void)start;
#if NS_BLOCKS_AVAILABLE
-(void)startWithEndingBlock:(void(^)(NSTimeInterval countTime))end; //use it if you are not going to use delegate
#endif
-(void)pause;
-(void)reset;

/*--------Setter methods*/
-(void)setTimeFormat:(NSString*)timeFormat;
-(void)setCountDownTime:(NSTimeInterval)time;
-(void)setStopWatchTime:(NSTimeInterval)time;
-(void)setCountDownToDate:(NSDate*)date;

-(void)addTimeCountedByTime:(NSTimeInterval)timeToAdd;

/*--------Getter methods*/
- (NSTimeInterval)getTimeCounted;

@end
