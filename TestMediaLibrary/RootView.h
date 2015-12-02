//
//  RootView.h
//  TestMLMediaLibrary
//
//  Created by AnarL on 11/30/15.
//  Copyright © 2015 AnarL. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RootViewController.h"


@import MediaLibrary;

@interface RootView : NSView
{
    MLMediaLibrary * _photoLib;
    MLMediaLibrary * _musicLib;
    
    MLMediaSource * _photosSource;
    MLMediaSource * _photoBoothSource;
    MLMediaSource * _iTunesSource;
    
    MLMediaGroup * _photosRootGroup;
    MLMediaGroup * _photoBoothRootGroup;
    MLMediaGroup * _iTunesRootGroup;
    
    NSArray * _photosObjects;
    NSArray * _photoBoothObjects;
    NSArray * _iTunesObjects;
    
    NSOutlineView * _outlineView;
    
    MLMediaGroup * _rootGroup;
    
}



@end
