//
//  MainViewController.m
//  qxReachability
//
//  Created by Dynamiter on 6/29/13.
//  Copyright (c) 2013 Dynamiter. All rights reserved.
//

#import "MainViewController.h"
#import "Reachability.h"

@interface MainViewController ()
{
    Reachability *internetReach;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];

    
    [_tfStatus setText:@"Program initialized.\n"];
    
    if ([self isInternetAvailable]) {
        [_tfStatus setText:[NSString stringWithFormat: @"%@\n%@\n", _tfStatus.text, @"Network is Good."]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isInternetAvailable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        return YES;
    }
    return NO;
}

- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case ReachableViaWWAN:
        {
            NSLog(@"Network available via 3G or 4G.");
            break;
        }
        case ReachableViaWiFi:
        {
            [_tfStatus setText:[NSString stringWithFormat: @"%@\n%@\n", _tfStatus.text, @"Network via WIFI."]];
            NSLog(@"Network available via WIFI.");
            break;
        }
        case NotReachable:
        {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"We are unable to make a internet connection at this time. Some functionality will be limited until a connection is made." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
            [_tfStatus setText:[NSString stringWithFormat: @"%@\n%@\n", _tfStatus.text, @"Network unavailable."]];
            NSLog(@"Network unavailable.");
            break;
        }
    }
}
- (IBAction)clearStatus:(id)sender {
    [_tfStatus setText:@""];
}
@end
