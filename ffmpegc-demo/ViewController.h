//
//  ViewController.h
//  ffmpegc-demo
//
//  Created by 吕健 on 12-11-23.
//  Copyright (c) 2012年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoFrameExtractor.h"

@interface ViewController : UIViewController {
	float lastFrameTime;
}

@property(strong, nonatomic) IBOutlet UIImageView *videoView;
@property(strong, nonatomic) IBOutlet UILabel *label;

@property(strong, nonatomic) IBOutlet UIBarButtonItem *playButton;


@property (nonatomic, strong) VideoFrameExtractor *video;

-(IBAction)playClicked:(id)sender;


@end
