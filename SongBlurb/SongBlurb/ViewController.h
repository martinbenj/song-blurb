//
//  ViewController.h
//  SongBlurb
//
//  Created by Benjamin Martin on 4/23/14.
//  Copyright (c) 2014 Benjamin Martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate, AVAudioRecorderDelegate>

@property (strong, nonatomic) IBOutlet UIButton *recordButton;
- (IBAction)recordTapped:(id)sender;

@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) AVAudioPlayer *player;


@end
