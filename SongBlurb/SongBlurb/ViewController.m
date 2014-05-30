//
//  ViewController.m
//  SongBlurb
//
//  Created by Benjamin Martin on 4/23/14.
//  Copyright (c) 2014 Benjamin Martin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *ezPath = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"sample.caf", nil];
    
    self.microphone = [EZMicrophone microphoneWithDelegate:self];
    self.EZRecorder = [EZRecorder recorderWithDestinationURL:[NSURL fileURLWithPathComponents:ezPath] andSourceFormat:self.microphone.audioStreamBasicDescription];
    
    self.audioPlot.backgroundColor = [UIColor whiteColor];
    self.audioPlot.color = [UIColor blackColor];
    // Plot type
    self.audioPlot.plotType     = EZPlotTypeRolling;
    // Fill
    self.audioPlot.shouldFill   = YES;
    // Mirror
    self.audioPlot.shouldMirror = YES;
    
    [self.microphone startFetchingAudio];
    
    // Setup audio session
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    // Add error handling
    // Output file must be .m4a, not .mp3
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], @"audio-sample.m4a", nil];
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    // Define the recorder setting
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    
    [recordSettings setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSettings setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSettings setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
    // Initiate and prepare the recorder
    // outputFileURL is where the recorded audio will be stored (defined above).
    self.recorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL settings:recordSettings error:NULL];
    self.recorder.delegate = self;
    self.recorder.meteringEnabled = YES;
    [self.recorder prepareToRecord];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordTapped:(id)sender {
    // Stop the audio player before recording
    if (self.player.playing) {
        [self.player stop];
    }
    
    if (!self.recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        
        // Start recording
        [self.recorder record];
        [self.recordPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
    
    [self.stopButton setEnabled:YES];
    [self.playButton setEnabled:NO];
}


- (IBAction)stopTapped:(id)sender {
    [self.recorder stop];
    [self.recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    [self.playButton setEnabled:YES];
    [self.stopButton setEnabled:NO];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
}

- (IBAction)playTapped:(id)sender {
    [self.recordPauseButton setEnabled:NO];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recorder.url error:nil];
    self.player.delegate = self;
    [self.player play];
}

#pragma mark - AVAudioPlayerDelegate methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Recording finished"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [self.recordPauseButton setEnabled:YES];
    [alert show];
}

#pragma mark - EZAudioMicrophoneDelegate

- (void)microphone:(EZMicrophone *)microphone
 hasAudioReceived:(float **)buffer
   withBufferSize:(UInt32)bufferSize
withNumberOfChannels:(UInt32)numberOfChannels {
	dispatch_async(dispatch_get_main_queue(),^{
        [self.audioPlot updateBuffer:buffer[0] withBufferSize:bufferSize];
	});
}

- (void)microphone:(EZMicrophone *)microphone
       hasBufferList:(AudioBufferList *)bufferList
      withBufferSize:(UInt32)bufferSize
withNumberOfChannels:(UInt32)numberOfChannels {
    [self.EZRecorder appendDataFromBufferList:bufferList
                                 withBufferSize:bufferSize];
}


@end
