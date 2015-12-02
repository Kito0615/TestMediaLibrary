//
//  AppDelegate.h
//  TestMediaLibrary
//
//  Created by AnarL on 12/2/15.
//  Copyright © 2015 AnarL. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RootView.h"
#import "RootViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    RootView * _rootView;
    RootViewController * _rootVC;
}


@end

