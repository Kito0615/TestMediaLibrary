//
//  RootViewController.m
//  TestMLMediaLibrary
//
//  Created by AnarL on 11/30/15.
//  Copyright © 2015 AnarL. All rights reserved.
//


#import "RootViewController.h"

@import MediaLibrary;

#import "RootView.h"

@interface RootViewController ()
{
    RootView * _rootView;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    _imageArr = [[NSMutableArray alloc] init];
    _audioArr = [[NSMutableArray alloc] init];
    
    self.audioTableView.delegate = self;
    self.audioTableView.dataSource = self;
    
    
    _rootView = [[RootView alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedImages:) name:RECEIVEDIMAGESNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedAudios:) name:RECEIVEDAUDIOSNOTIFICATION object:nil];

}

#pragma mark -Notification
- (void)receivedImages:(NSNotification *)notification
{
    static NSInteger count = 1;
    
    CGFloat imageW = 160;
    CGFloat imageH = 120;
    
    CGFloat imageX = ((count - 1) % 4) * (imageW + 20) + 10;
    CGFloat imageY = ((count - 1) / 4) * (imageH + 20) + 10;
    
    NSImageView * imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(imageX, imageY, imageW, imageH)];
    
    imageView.image = notification.object;
    
//    [self.showAllImages addSubview:imageView];
    [self.showAllImages.documentView addSubview:imageView];
    
    [self.showAllImages.documentView setFrameSize:NSMakeSize((imageW + 20) * 4 - 20, imageY + imageH + 10)];
    
//    NSLog(@"size.width = %.2f, size.height = %.2f", self.showAllImages.contentSize.width, self.showAllImages.contentSize.height);
//    NSLog(@"size.width = %.2f, size.height = %.2f", self.showAllImages.bounds.size.width, self.showAllImages.bounds.size.height);
    
//    self.showAllImages
    
//    NSLog(@"%@", notification.object);
    
    [_imageArr addObject:notification.object];
    
//    NSLog(@"%@", _imageArr);
    
    NSLog(@"收到通知");
    
    count ++;
    
}

- (void)receivedAudios:(NSNotification *)notification
{
    MLMediaObject * audioObject = notification.object;
    
    [_audioArr addObject:audioObject];
    
    [self.audioTableView reloadData];
    
//    NSLog(@"%@", audioObject.attributes);
//    NSLog(@"source id :%@", audioObject.url);
}

#pragma mark -NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return _audioArr.count > 0 ? _audioArr.count : 0;
}



- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    MLMediaObject * object = _audioArr[row];
    
    NSString * audioURL = [NSString stringWithFormat:@"%@", [object.attributes objectForKey:@"URL"]];
    NSMutableString * audioPathString = [NSMutableString stringWithString:[audioURL substringFromIndex:7]];
    
    NSString * audioPath = [[NSMutableString alloc] init];
    
    if (![audioPathString performSelector:@selector(stringByRemovingPercentEncoding)]) {
        
        audioPath = [audioPathString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    } else {
        audioPath = [audioPathString stringByRemovingPercentEncoding];
    }
    
    if ([tableColumn.identifier isEqualToString:@"name"]) {
        return [[object.attributes objectForKey:@"name"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    if ([tableColumn.identifier isEqualToString:@"Artist"]) {
        return [[object.attributes objectForKey:@"Artist"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    if ([tableColumn.identifier isEqualToString:@"Album"]) {
        return [[object.attributes objectForKey:@"Album"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    if ([tableColumn.identifier isEqualToString:@"fileSize"]) {
        
        NSInteger filesize = [[object.attributes objectForKey:@"fileSize"] integerValue];
        
        NSString * fileSize = [NSString stringWithFormat:@"%.2f MB", filesize / (1024.0 * 1024.0)];
        
        
        return fileSize;
    }
    return nil;
}

- (BOOL)tableView:(NSTableView *)tableView shouldReorderColumn:(NSInteger)columnIndex toColumn:(NSInteger)newColumnIndex
{
    return YES;
}

#pragma mark -NSTableViewDelegate


- (BOOL)tableView:(NSTableView *)tableView shouldSelectTableColumn:(NSTableColumn *)tableColumn
{
    return YES;
}
- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn
{
    for (int i = 0; i < _audioArr.count; i++) {
        for (int j = 0; j < i; j++) {
            
            MLMediaObject * objectAtIndexI = _audioArr[i];
            MLMediaObject * objectAtIndexJ = _audioArr[j];
            
            if ( [objectAtIndexI.attributes objectForKey:tableColumn.identifier] < [objectAtIndexJ.attributes objectForKey:tableColumn.identifier]) {
                [_audioArr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
            
        }
    }
    [tableView reloadData];
}

- (void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray<NSSortDescriptor *> *)oldDescriptors
{
    [_audioArr sortUsingDescriptors:tableView.sortDescriptors];
    [tableView reloadData];
}


- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row
{
    MLMediaObject * object = _audioArr[row];
    
    NSString * path = [NSString stringWithFormat:@"%@", [object.attributes objectForKey:@"URL"]];
    
    NSLog(@"%@", [[path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] substringFromIndex:7]);
    return YES;
}



@end
