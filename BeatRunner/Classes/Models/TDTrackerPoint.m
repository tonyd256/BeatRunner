//
//  TDTrackerPoint.m
//  BeatRunner
//
//  Created by Tony DiPasquale on 2/8/14.
//
//

#import <CoreLocation/CoreLocation.h>
#import "TDTrackerPoint.h"

@implementation TDTrackerPoint

- (instancetype)initWithLocation:(CLLocation *)location
{
    self = [super init];
    if (!self) return nil;

    self.timestamp = location.timestamp;
    self.latitude = location.coordinate.latitude;
    self.longitude = location.coordinate.longitude;

    return self;
}

@end
