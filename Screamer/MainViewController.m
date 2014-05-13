//
//  MainViewController.m
//  Screamer
//
//  Created by Patrick Lackemacher on 5/13/14.
//  Copyright (c) 2014 Patrick Lackemacher. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>
#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        [self createSound];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.view.backgroundColor = [UIColor greenColor];

    self.motionManager = [CMMotionManager new];
    self.motionManager.accelerometerUpdateInterval = 0.025;

    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * accelerometerData, NSError * error) {
        CMAcceleration acceleration = accelerometerData.acceleration;

        // Acceleration here is passed in G's so we need to multiply by our units (9.81 m/s^2)
        double magnitude = sqrt(acceleration.x * acceleration.x + acceleration.y * acceleration.y + acceleration.z * acceleration.z) * 9.81;

        if(magnitude < 5) {
            self.view.backgroundColor = [UIColor redColor];

            [self playSound];
        } else {
            self.view.backgroundColor = [UIColor greenColor];

            [self stopSound];
        }
    }];
}

- (void)dealloc {
    [self.motionManager stopAccelerometerUpdates];
}

- (void)createSound {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"scream2" ofType:@"mp3"];
    NSURL * url = [NSURL fileURLWithPath:path];

    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];

    self.audioPlayer.volume = 1.0;
    // Play an infinite number of times until stopped
    self.audioPlayer.numberOfLoops = -1;
}

- (void)playSound {
    [self.audioPlayer play];
}

- (void)stopSound {
    [self.audioPlayer stop];
    self.audioPlayer.currentTime = 0;
}


@end
