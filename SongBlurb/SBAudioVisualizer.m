//
//  SBAudioVisualizer.m
//  SongBlurb
//
//  Created by Benjamin Martin on 5/24/14.
//  Copyright (c) 2014 Benjamin Martin. All rights reserved.
//

#import "SBAudioVisualizer.h"

@implementation SBAudioVisualizer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		_microphone = [EZMicrophone microphoneWithDelegate:self];
        _frequency = 1.5;
		_phase = 0;
		_amplitude = 1.0;
		_whiteValue = 1.0;
		_idleAmplitude = 0.1;
		_dampingFactor = 0.86;
		_waves = 5;
		_phaseShift = -0.15;
		_density = 5.0;
    }
    return self;
}

#pragma mark - EZMicrophoneDelegate
#warning Thread Safety

-(void)microphone:(EZMicrophone *)microphone
 hasAudioReceived:(float **)buffer
   withBufferSize:(UInt32)bufferSize
withNumberOfChannels:(UInt32)numberOfChannels {
    
    NSLog(@"accessed microphone");
	
//	dispatch_async(dispatch_get_main_queue(),^{
//		
//		int requiredTickes = 1; // Alter this to draw more or less often
//		tick = (tick+1)%requiredTickes;
//		
//		// Let's use the buffer's first float value to determine the current sound level.
//		float value = fabsf(*buffer[0]);
//		
//		/// If we defined the current sound level as the amplitude of the wave, the wave would jitter very nervously.
//		/// To avoid this, we use an inert amplitude that lifts slowly if the value is currently high, and damps itself
//		/// if the value decreases.
//		if (value > _dampingAmplitude) _dampingAmplitude += (fmin(value,1.0)-_dampingAmplitude)/4.0;
//		else if (value<0.01) _dampingAmplitude *= _dampingFactor;
//		
//		_phase += _phaseShift;
//		_amplitude = fmax( fmin(_dampingAmplitude*20, 1.0), _idleAmplitude);
//        
////		[self setNeedsDisplay:tick==0];
//	});
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
