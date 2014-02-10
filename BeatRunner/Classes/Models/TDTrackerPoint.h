//
//  TDTrackerPoint.h
//  BeatRunner
//
//  Created by Tony DiPasquale on 2/8/14.
//
//

@class CLLocation;

@interface TDTrackerPoint : NSObject

@property (nonatomic) NSDate *timestamp;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;

- (instancetype)initWithLocation:(CLLocation *)location;

@end
