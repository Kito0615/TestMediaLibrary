//
//  AppDelegate.m
//  TestMediaLibrary
//
//  Created by AnarL on 12/2/15.
//  Copyright © 2015 AnarL. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    _rootVC = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    
    [self.window.contentView addSubview:_rootVC.view];
    
    //
    //    _rootView = [[RootView alloc] init];
    //
    //    _rootView.frame = NSMakeRect(self.window.frame.origin.x, self.window.frame.origin.y, self.window.frame.size.width, self.window.frame.size.height - 22);
    //
    //    [self.window.contentView addSubview:_rootView];
    //    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
