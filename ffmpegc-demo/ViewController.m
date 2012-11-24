//
//  ViewController.m
//  ffmpegc-demo
//
//  Created by 吕健 on 12-11-23.
//  Copyright (c) 2012年 lv. All rights reserved.
//

#import "ViewController.h"
#import "Utilities.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	DLog(@"initialize VideoFrameExtractor...");
	self.video = [[VideoFrameExtractor alloc] initWithVideo:[Utilities bundlePath:@"for_the_birds.avi"]];
	DLog(@"success.");
	
	DLog(@"setting video exetractor size....");
	self.video.outputWidth = 426;
	self.video.outputHeight = 320;
	// Do any additional setup after loading the view, typically from a nib.
	
	
	NSLog(@"video duration: %f", self.video.duration);
	NSLog(@"video size: %d x %d", self.video.sourceWidth, self.video.sourceHeight);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playClicked:(id)sender {
	DLog(@"play clicked... playing....");
	[_playButton setEnabled:NO];
	lastFrameTime = -1;
	
	// seek to 0.0 seconds
	[_video seekTime:0.0];
	
	//	float nFrame = 1.0/10;
	// 帧数
	// N 制: 中国使用, 每秒25帧
	// Pal 制: 国外使用, 每秒30帧
	float palFrame = 1.0/30; // PAL Mode
	
	[NSTimer scheduledTimerWithTimeInterval:palFrame
									 target:self
								   selector:@selector(displayNextFrame:)
								   userInfo:nil
									repeats:YES];
}

#define LERP(A,B,C) ((A)*(1.0-C)+(B)*C)

-(void)displayNextFrame:(NSTimer *)timer {
	NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
	
	if (![_video stepFrame]) {
		[timer invalidate];
		[_playButton setEnabled:YES];
		return;
	}
	
	_videoView.image = _video.currentImage;
	
	float frameTime = 1.0/([NSDate timeIntervalSinceReferenceDate]-startTime);
	if (lastFrameTime<0) {
		lastFrameTime = frameTime;
	} else {
		lastFrameTime = LERP(frameTime, lastFrameTime, 0.8);
	}
	
	[_label setText:[NSString stringWithFormat:@"%.0f",lastFrameTime]];
}


@end
