//
//  OHTimerLabel.m
//  oneHookLibrary
//
//  Created by EagleDiao@Optimity on 2017-06-06.
//  Copyright © 2017 oneHook inc. All rights reserved.
//

#import "OHTimerLabel.h"

#define kDefaultTimeFormat  @"HH:MM:SS"
#define kDefaultFireIntervalNormal  0.1
#define kDefaultFireIntervalHighUse  0.02
#define kDefaultTimerType OHTimerLabelTypeStopWatch

@interface OHTimerLabel(){
    
#if NS_BLOCKS_AVAILABLE
    void (^endedBlock)(NSTimeInterval);
#endif
    NSTimeInterval timeUserValue;
    NSDate *startCountDate;
    NSDate *pausedTime;
    NSDate *date1970;
    NSDate *timeToCountOff;
}

@property (strong) NSTimer *timer;
@property (strong, nonatomic) NSString* parsedTimeFormat;

- (void)setup;
- (void)updateLabel;

@end

#pragma mark - Initialize method

@implementation OHTimerLabel

- (id)initWithTimerType:(OHTimerLabelType)theType{
    return [self initWithLabel:nil andTimerType:theType];
}

- (id)initWithLabel:(UILabel *)theLabel andTimerType:(OHTimerLabelType)theType
{
    self = [super init];
    
    if(self){
        self.timeLabel = theLabel;
        self.timerType = theType;
        [self setup];
    }
    return self;
}

- (id)initWithLabel:(UILabel*)theLabel{
    return [self initWithLabel:theLabel andTimerType:kDefaultTimerType];
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - Getter and Setter Method

- (void)setTimeFormat:(NSString *)timeFormat
{
    NSMutableString* sb = [[NSMutableString alloc] init];
    
    BOOL shouldIgnore = NO;
    for(int i = 0; i < timeFormat.length;) {
        
        if([timeFormat characterAtIndex:i] == '\'') {
            shouldIgnore = !shouldIgnore;
            i++;
        } else if(shouldIgnore) {
            [sb appendFormat:@"%c", [timeFormat characterAtIndex:i]];
            i++;
            continue;
        } else if([[timeFormat substringWithRange:NSMakeRange(i, 2)] isEqualToString:@"DD"]) {
            [sb appendString:@"%1$d"];
            i+=2;
        } else if([[timeFormat substringWithRange:NSMakeRange(i, 2)] isEqualToString:@"HH"]) {
            [sb appendString:@"%2$02d"];
            i+=2;
        } else if([[timeFormat substringWithRange:NSMakeRange(i, 2)] isEqualToString:@"MM"]) {
            [sb appendString:@"%3$02d"];
            i+=2;
        } else if([[timeFormat substringWithRange:NSMakeRange(i, 2)] isEqualToString:@"SS"]) {
            [sb appendString:@"%4$02d"];
            i+=2;
        } else if([[timeFormat substringWithRange:NSMakeRange(i, 2)] isEqualToString:@"MS"]) {
            [sb appendString:@"%5$03d"];
            i+=2;
        } else {
            [sb appendFormat:@"%c", [timeFormat characterAtIndex:i]];
            i++;
        }
    }
    _parsedTimeFormat = sb.description;
}

- (void)setStopWatchTime:(NSTimeInterval)time{
    
    timeUserValue = (time < 0) ? 0 : time;
    if(timeUserValue > 0){
        startCountDate = [[NSDate date] dateByAddingTimeInterval:-timeUserValue];
        pausedTime = [NSDate date];
        [self updateLabel];
    }
}

- (void)setCountDownTime:(NSTimeInterval)time{
    
    timeUserValue = (time < 0)? 0 : time;
    timeToCountOff = [date1970 dateByAddingTimeInterval:timeUserValue];
    [self updateLabel];
}

-(void)setCountDownToDate:(NSDate*)date{
    NSTimeInterval timeLeft = (int)[date timeIntervalSinceDate:[NSDate date]];
    
    if (timeLeft > 0) {
        timeUserValue = timeLeft;
        timeToCountOff = [date1970 dateByAddingTimeInterval:timeLeft];
    }else{
        timeUserValue = 0;
        timeToCountOff = [date1970 dateByAddingTimeInterval:0];
    }
    [self updateLabel];
    
}

- (UILabel*)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = self;
    }
    return _timeLabel;
}


-(void)addTimeCountedByTime:(NSTimeInterval)timeToAdd
{
    startCountDate = [startCountDate dateByAddingTimeInterval:-timeToAdd];
    [self updateLabel];
}


- (NSTimeInterval)getTimeCounted
{
    NSTimeInterval countedTime = [[NSDate date] timeIntervalSinceDate:startCountDate];
    
    if(pausedTime != nil){
        NSTimeInterval pauseCountedTime = [[NSDate date] timeIntervalSinceDate:pausedTime];
        countedTime -= pauseCountedTime;
    }
    return countedTime;
}

#pragma mark - Timer Control Method


-(void)start{
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if ([self.parsedTimeFormat rangeOfString:@"%5$03d"].location != NSNotFound) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalHighUse target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }else{
        _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalNormal target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    if(startCountDate == nil){
        startCountDate = [NSDate date];
        
        if (self.timerType == OHTimerLabelTypeStopWatch && timeUserValue > 0) {
            startCountDate = [startCountDate dateByAddingTimeInterval:(timeUserValue<0)?0:-timeUserValue];
        }
    }
    if(pausedTime != nil){
        NSTimeInterval countedTime = [pausedTime timeIntervalSinceDate:startCountDate];
        startCountDate = [[NSDate date] dateByAddingTimeInterval:-countedTime];
        pausedTime = nil;
    }
    
    _counting = YES;
    [_timer fire];
}

#if NS_BLOCKS_AVAILABLE
-(void)startWithEndingBlock:(void(^)(NSTimeInterval))end{
    [self start];
    endedBlock = end;
}
#endif

-(void)pause{
    if(_counting){
        [_timer invalidate];
        _timer = nil;
        _counting = NO;
        pausedTime = [NSDate date];
    }
}

-(void)reset{
    pausedTime = nil;
    timeUserValue = (self.timerType == OHTimerLabelTypeStopWatch)? 0 : timeUserValue;
    startCountDate = (self.counting)? [NSDate date] : nil;
    [self updateLabel];
}


#pragma mark - Private method

-(void)setup{
    date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    [self setTimeFormat:kDefaultTimeFormat];
    [self updateLabel];
}


-(void)updateLabel{
    
    NSTimeInterval timeDiff = [[[NSDate alloc] init] timeIntervalSinceDate:startCountDate];
    NSDate *timeToShow = [NSDate date];
    
    /***OHTimerLabelTypeStopWatch Logic***/
    
    if(_timerType == OHTimerLabelTypeStopWatch){
        
        if (_counting) {
            timeToShow = [date1970 dateByAddingTimeInterval:timeDiff];
        }else{
            timeToShow = [date1970 dateByAddingTimeInterval:(!startCountDate)?0:timeDiff];
        }
        
        if([_delegate respondsToSelector:@selector(timerLabel:countingTo:timertype:)]){
            [_delegate timerLabel:self countingTo:timeDiff timertype:_timerType];
        }
        
    }else{
        
        /***OHTimerLabelTypeTimer Logic***/
        
        if (_counting) {
            
            if([_delegate respondsToSelector:@selector(timerLabel:countingTo:timertype:)]){
                NSTimeInterval timeLeft = timeUserValue - timeDiff;
                [_delegate timerLabel:self countingTo:timeLeft timertype:_timerType];
            }
            
            if(timeDiff >= timeUserValue){
                [self pause];
                timeToShow = [date1970 dateByAddingTimeInterval:0];
                pausedTime = nil;
                startCountDate = nil;
                
                if([_delegate respondsToSelector:@selector(timerLabel:finshedCountDownTimerWithTime:)]){
                    [_delegate timerLabel:self finshedCountDownTimerWithTime:timeUserValue];
                }
                
#if NS_BLOCKS_AVAILABLE
                if(endedBlock != nil){
                    endedBlock(timeUserValue);
                }
#endif
                if(_resetTimerAfterFinish){
                    [self reset];
                    return;
                }
                
            }else{
                
                timeToShow = [timeToCountOff dateByAddingTimeInterval:(timeDiff*-1)]; //added 0.999 to make it actually counting the whole first second
            }
        }else{
            timeToShow = timeToCountOff;
        }
    }
    
    //setting text value
    if ([_delegate respondsToSelector:@selector(timerLabel:customTextToDisplayAtTime:)]) {
        NSTimeInterval atTime = (_timerType == OHTimerLabelTypeStopWatch) ? timeDiff : (timeUserValue - timeDiff);
        NSString *customtext = [_delegate timerLabel:self customTextToDisplayAtTime:atTime];
        if ([customtext length]) {
            self.timeLabel.text = customtext;
            return;
        }
    }
    
    long milliseconds = timeToShow.timeIntervalSince1970 * 1000;
    
    long mili = milliseconds % 1000;
    long seconds = (milliseconds / 1000) % 60;
    long minute = (milliseconds / 60000) % 60;
    long hour = (milliseconds / 3600000) % 24;
    long day = milliseconds / 86400000;
    
    NSString *strDate = [NSString stringWithFormat:_parsedTimeFormat, day, hour, minute, seconds, mili];
    self.timeLabel.text = strDate;
}

@end
