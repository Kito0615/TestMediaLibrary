//
//  RootViewController.h
//  TestMLMediaLibrary
//
//  Created by AnarL on 11/30/15.
//  Copyright © 2015 AnarL. All rights reserved.
//


#define RECEIVEDIMAGESNOTIFICATION @"receivedimages"
#define RECEIVEDAUDIOSNOTIFICATION @"receivedaudios"

#import <Cocoa/Cocoa.h>



@interface RootViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>
{
    NSMutableArray * _imageArr;
    NSMutableArray * _audioArr;
}

@property (weak) IBOutlet NSTableView *audioTableView;
@property (weak) IBOutlet NSScrollView *showAllImages;

@end
