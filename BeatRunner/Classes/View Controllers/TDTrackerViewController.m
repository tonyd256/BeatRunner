//
//  TDTrackerViewController.m
//  BeatRunner
//
//  Created by Tony DiPasquale on 2/8/14.
//
//

#import <CoreLocation/CoreLocation.h>
#import "TDTrackerViewController.h"
#import "TDTrackerPoint.h"

@interface TDTrackerViewController () <CLLocationManagerDelegate>

@property (nonatomic) IBOutlet UISwitch *musicSwitch;
@property (nonatomic) IBOutlet UIButton *trackButton;
@property (nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic) IBOutlet UILabel *elapsedLabel;
@property (nonatomic) IBOutlet UILabel *distanceLabel;
@property (nonatomic) IBOutlet UILabel *paceLabel;

@property (nonatomic) CLLocationManager *manager;
@property (nonatomic) NSMutableArray *points;
@property (nonatomic) CLLocationDistance distance;
@property (nonatomic) double elapsedTime;

@end

@implementation TDTrackerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.trackButton.layer.cornerRadius = 50.0f;
    self.points = [NSMutableArray array];

    if ([CLLocationManager locationServicesEnabled]) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.activityType = CLActivityTypeFitness;
        self.manager.delegate = self;
        [self.manager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = (CLLocation *)[locations lastObject];

    if (self.points.count) {
        CLLocation *formerLocation = [self.points lastObject];
        [self updateLabelsWithFormerLocation:formerLocation newLocation:location];
    }

    [self.points addObject:location];
}

- (void)updateLabelsWithFormerLocation:(CLLocation *)former newLocation:(CLLocation *)new
{
    CLLocationDistance distance = [former distanceFromLocation:new];
    self.distance += distance;
    self.distanceLabel.text = [self formatDecimal:[self milesFromMeters:self.distance]];

    CGFloat elapsedTime = [new.timestamp timeIntervalSinceDate:former.timestamp];
    self.elapsedTime += elapsedTime;

    NSUInteger min = self.elapsedTime / 60;
    NSUInteger sec = self.elapsedTime - min * 60;
    self.elapsedLabel.text = [NSString stringWithFormat:@"%02d:%02d", min, sec];

    double pace = (self.elapsedTime / [self milesFromMeters:self.distance]);
    NSUInteger minp = pace / 60;
    NSUInteger secp = pace - minp * 60;
    self.paceLabel.text = [NSString stringWithFormat:@"%02d:%02d", minp, secp];
    NSLog(@"pace: %f", [self milesFromMeters:self.distance]);
}

- (double)milesFromMeters:(double)meters
{
    return meters / 1609.344;
}

- (NSString *)formatDecimal:(double)decimal
{
    return [NSString stringWithFormat:@"%.02f", floor(decimal * 100) / 100];
}

@end
