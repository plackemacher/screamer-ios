//
//  MainViewController.h
//  Screamer
//
//  Created by Patrick Lackemacher on 5/13/14.
//  Copyright (c) 2014 Patrick Lackemacher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) CMMotionManager * motionManager;
@property (strong, nonatomic) AVAudioPlayer * audioPlayer;

@end
