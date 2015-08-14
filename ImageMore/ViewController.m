//
//  ViewController.m
//  ImageMore
//
//  Created by Eric on 15/6/16.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Group.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentMain;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewMain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self segmentClick:_segmentMain];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    _layHeight.constant = 250;
    _layWidth.constant = _layHeight.constant;
}

- (IBAction)segmentClick:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    index++;
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             [UIImage imageNamed:@"1"],
                             [UIImage imageNamed:@"2"],
                             [UIImage imageNamed:@"3"],
                             [UIImage imageNamed:@"4"],
                             [UIImage imageNamed:@"5"],
                             [UIImage imageNamed:@"6"],
                             nil];

    _imageViewMain.image = [UIImage creatGroupImage:[array subarrayWithRange:NSMakeRange(0, index)]
                                          backColor:[UIColor clearColor]
                                               size:_imageViewMain.frame.size
                                               edge:0
                                              scale:0];
    
}


@end
