//
//  RootView.m
//  TestMLMediaLibrary
//
//  Created by AnarL on 11/30/15.
//  Copyright © 2015 AnarL. All rights reserved.
//

#import "RootView.h"

@implementation RootView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _photoLib = [[MLMediaLibrary alloc] initWithOptions:@{ MLMediaLoadSourceTypesKey : @(MLMediaTypeImage)}];
    _musicLib = [[MLMediaLibrary alloc] initWithOptions:@{ MLMediaLoadSourceTypesKey : @(MLMediaTypeAudio)}];
    
    [_photoLib addObserver:self forKeyPath:@"mediaSources" options:0 context:(__bridge void *)@"photoLibraryLoaded"];
    [_musicLib addObserver:self forKeyPath:@"mediaSources" options:0 context:(__bridge void *)@"musicLibraryLoaded"];
    
    NSLog(@"%@", _photoLib.mediaSources);
    NSLog(@"%@", _musicLib.mediaSources);
    
}

- (instancetype)init
{
    if (self = [super init]) {
        
        _photoLib = [[MLMediaLibrary alloc] initWithOptions:@{ MLMediaLoadSourceTypesKey : @(MLMediaTypeImage)}];
        _musicLib = [[MLMediaLibrary alloc] initWithOptions:@{ MLMediaLoadSourceTypesKey : @(MLMediaTypeAudio)}];
        
        [_photoLib addObserver:self forKeyPath:@"mediaSources" options:0 context:(__bridge void *)@"photoLibraryLoaded"];
        [_musicLib addObserver:self forKeyPath:@"mediaSources" options:0 context:(__bridge void *)@"musicLibraryLoaded"];
        
        NSLog(@"%@", _photoLib.mediaSources);
        NSLog(@"%@", _musicLib.mediaSources);
        
        _outlineView = [[NSOutlineView alloc] initWithFrame:NSMakeRect(0, 0, 420, 420)];

    }
    
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (context == (__bridge  void *)@"photoLibraryLoaded") {
        NSLog(@"=========photo Library Loaded==========");
        NSLog(@"%@", _photoLib.mediaSources);
        
        _photosSource = [_photoLib.mediaSources objectForKey:@"com.apple.Photos"];
        
        NSLog(@"%@", _photosSource.rootMediaGroup);
        [_photosSource addObserver:self forKeyPath:@"rootMediaGroup" options:0 context:(__bridge void *)@"photosRootGroup"];
        
        
        
        _photoBoothSource = [_photoLib.mediaSources objectForKey:@"com.apple.PhotoBooth"];
        NSLog(@"%@", _photoBoothSource.rootMediaGroup);
        [_photoBoothSource addObserver:self forKeyPath:@"rootMediaGroup" options:0 context:(__bridge void *)@"photoBoothRootGroup"];
        
    }
    if (context == (__bridge void *)@"musicLibraryLoaded"){
        NSLog(@"=========music library loaded=========");
        NSLog(@"%@", _musicLib.mediaSources);
        
        _iTunesSource = [_musicLib.mediaSources objectForKey:@"com.apple.iTunes"];
        [_iTunesSource addObserver:self forKeyPath:@"rootMediaGroup" options:0 context:(__bridge void *)@"iTunesRootGroup"];
        NSLog(@"%@", _iTunesSource.rootMediaGroup);
        
    }
    
    if (context == (__bridge void *)@"photosRootGroup") {
        
//        NSLog(@"%@", _photosSource.rootMediaGroup);
        
        _photosRootGroup = _photosSource.rootMediaGroup;
        
//        NSLog(@"%@", _photosRootGroup.identifier);
        
        NSLog(@"==========all photos groups==========");
        
        [self printChildGroups:_photosRootGroup];
        
        
        
        _photosObjects = _photosRootGroup.mediaObjects;
        
        [_photosRootGroup addObserver:self forKeyPath:@"mediaObjects" options:0 context:(__bridge void *)@"photoInPhotos"];
        
    }
    if (context == (__bridge void *)@"photoBoothRootGroup") {
        
//        NSLog(@"%@", _photoBoothSource.rootMediaGroup);
        
        _photoBoothRootGroup = _photoBoothSource.rootMediaGroup;
        
//        NSLog(@"%@", _photoBoothRootGroup.identifier);
        
        NSLog(@"==========all photoBooth groups==========");
        
        _rootGroup = _photosRootGroup;

        [self printChildGroups:_photoBoothRootGroup];
        
        
        
        _photoBoothObjects = _photoBoothRootGroup.mediaObjects;
        
        [_photoBoothRootGroup addObserver:self forKeyPath:@"mediaObjects" options:0 context:(__bridge void *)@"photoInPhotoBooth"];
        
        
    }
    if (context == (__bridge void *)@"iTunesRootGroup") {
        
//        NSLog(@"%@", _iTunesSource.rootMediaGroup);
        
        _iTunesRootGroup = _iTunesSource.rootMediaGroup;
        
//        NSLog(@"%@", _iTunesRootGroup.identifier);
        
        NSLog(@"==========all iTunes groups===========");
        
        [self printChildGroups:_iTunesRootGroup];
        
        
        
        _iTunesObjects = _iTunesRootGroup.mediaObjects;
        
        [_iTunesRootGroup addObserver:self forKeyPath:@"mediaObjects" options:0 context:(__bridge void *)@"audioIniTunes"];
        
    }
    
    if (context == (__bridge void *)@"photoInPhotos") {
        
        _photosObjects = _photosRootGroup.mediaObjects;
        
        NSLog(@"==========all photos in Photos==========");
        
        [self printMediaObjects:_photosRootGroup];
    }
    if (context == (__bridge void *)@"photoInPhotoBooth") {
        
        _photoBoothObjects = _photoBoothRootGroup.mediaObjects;
        
        NSLog(@"==========all photos in PhotoBooth==========");
        
        [self printMediaObjects:_photoBoothRootGroup];
    }
    if (context == (__bridge void *)@"audioIniTunes") {
        
        _iTunesObjects = _iTunesRootGroup.mediaObjects;
        
        NSLog(@"==========all audio files in iTunes==========");
        
        [self printMediaObjects:_iTunesRootGroup];
    }
    
    
    
    
}

- (void)printChildGroups:(MLMediaGroup *)parentGroup
{
    static int count = 0;
    
    NSMutableString * indexTree = [NSMutableString stringWithString:@""];
    
    for (int i = 0; i < count; i ++) {
        [indexTree appendString:@"-"];
    }
    
    if (parentGroup.childGroups.count != 0) {
        count++;
        for (MLMediaGroup * childGroup in parentGroup.childGroups) {
            [self printChildGroups:childGroup];
        }
    }else if (parentGroup.parent == nil){
        count = 0;
    } else if (parentGroup.parent != nil && parentGroup.childGroups.count != 0){
        count--;
    }
    
    NSLog(@"%@%@", indexTree, parentGroup.name);
    
}


- (void)printMediaObjects:(MLMediaGroup *)mediaGroup
{
    
    for (MLMediaObject * object in mediaGroup.mediaObjects) {
        
        NSLog(@"%@名称:%@" ,[object.contentType substringFromIndex:7] , object.name);
        
        if ([[object.attributes objectForKey:@"contentType"] isEqualToString:@"public.jpeg"]) {
            
            NSLog(@"image attributes:%@", object.attributes);
            
//            NSLog(@"timerInterval : %lf", [[object.attributes objectForKey:@"DateAsTimerInterval"] doubleValue]);
            
            NSDate * picDate = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:[[object.attributes objectForKey:@"DateAsTimerInterval"] doubleValue]];
            
            NSLog(@"picture date : %@", picDate);
            NSLog(@"modificationDate :%@", [object.attributes objectForKey:@"modificationDate"]);
            
            static int i = 0;
            
            CGFloat thumbnailX = i * 200 + 10;
            CGFloat thumbnailY = 50;
            CGFloat thumbnailW = 180;
            CGFloat thumbnailH = 150;
            
            NSImageView * imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(thumbnailX, thumbnailY, thumbnailW, thumbnailH)];
            
            [self.window.contentView addSubview:imageView];
            
            NSString * thumbnailURL = [NSString stringWithFormat:@"%@", [object.attributes objectForKey:@"thumbnailURL"]];
            
//            NSLog(@"%@", thumbnailURL);
            
            NSString * thumbnailPath = [thumbnailURL substringFromIndex:7];
            
//            NSLog(@"%@", thumbnailPath);
            
            NSString * imagePath = [thumbnailPath stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
//            NSLog(@"%@", imagePath);
            
            imageView.image = [[NSImage alloc] initWithContentsOfFile:imagePath];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVEDIMAGESNOTIFICATION object:[[NSImage alloc] initWithContentsOfFile:imagePath]];
            
        }
        
        if ([[object.attributes objectForKey:@"contentType"] isEqualToString:@"public.mp3"]) {
            
            
            [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVEDAUDIOSNOTIFICATION object:object];
            
        }
        
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
