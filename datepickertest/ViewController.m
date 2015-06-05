//
//  ViewController.m
//  datepickertest
//
//  Copyright (c) 2015 Applied Project Experience.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so.

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIPopoverController *ios7Popover;

- (IBAction)datePickerPopupIOS7:(UIButton *)sender;
- (IBAction)datePickerPopupIOS8:(UIButton *)sender;

@end


@implementation ViewController

// helper - returns a view controller containing a date picker for use in a
// popup
+ (UIViewController *)buildDatePickerViewController
{
    CGRect frame = CGRectMake(0, 0, 350, 216);
    
    UIViewController *viewController = [[UIViewController alloc]init];
    viewController.preferredContentSize = frame.size;
    UIDatePicker *datepicker = [[UIDatePicker alloc]initWithFrame:frame];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.hidden = NO;
    datepicker.date = [NSDate date];
    [viewController.view addSubview:datepicker];
    return viewController;
}

// popup date picker using UIPopoverController (IOS7 compatible)
- (IBAction)datePickerPopupIOS7:(UIButton *)sender
{
    UIViewController *viewController = [ViewController buildDatePickerViewController];
    
    self.ios7Popover = [[UIPopoverController alloc]initWithContentViewController:viewController];
    self.ios7Popover.delegate = self;
    [self.ios7Popover presentPopoverFromRect:sender.frame
                                      inView:self.view
                    permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown| UIPopoverArrowDirectionLeft|UIPopoverArrowDirectionRight)
                                    animated:YES];
}

// popup date picker using UIPopoverPresentationController (IOS8 or later required)
// Thanks to http://stackoverflow.com/a/26944036/1764243 for how to do this
- (IBAction)datePickerPopupIOS8:(UIButton *)sender
{
    if ([UIPopoverPresentationController class])
    {
        UIViewController *viewController = [ViewController buildDatePickerViewController];
        
        UINavigationController *destNav = [[UINavigationController alloc] initWithRootViewController:viewController];
        destNav.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *popover = destNav.popoverPresentationController;
        popover.delegate = self;
        popover.sourceView = self.view;
        popover.sourceRect = [sender frame];
        destNav.navigationBarHidden = YES;
        [self presentViewController:destNav animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Not supported"
                                                        message:@"UIPopoverPresentationController not supported in this version of IOS"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - UIPopoverControllerDelegate methods

 - (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.ios7Popover = nil;
}

@end
