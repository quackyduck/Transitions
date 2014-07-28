//
//  FirstViewController.h
//  Transitions
//
//  Created by Nicolas Melo on 7/27/14.
//  Copyright (c) 2014 melo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
