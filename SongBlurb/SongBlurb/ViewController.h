//
//  ViewController.h
//  SongBlurb
//
//  Created by Benjamin Martin on 4/23/14.
//  Copyright (c) 2014 Benjamin Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "EZAudio.h"

@interface ViewController : UIViewController <AVAudioPlayerDelegate, AVAudioRecorderDelegate, EZMicrophoneDelegate>

@property (strong, nonatomic) IBOutlet UIButton *recordButton;
- (IBAction)recordTapped:(id)sender;

@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) AVAudioPlayer *player;

@property (strong, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;

@property (strong, nonatomic) EZMicrophone *microphone;
@property (strong, nonatomic) EZRecorder *EZRecorder;
@property (strong, nonatomic) IBOutlet EZAudioPlot *audioPlot;

@end
