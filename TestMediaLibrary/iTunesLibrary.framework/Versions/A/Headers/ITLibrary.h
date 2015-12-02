/*!
	@header
	@copyright 2012 Apple Inc.
 */

#import <Foundation/Foundation.h>
#import <iTunesLibrary/ITLibDefines.h>

// Forward declaration.
@class ITLibMediaItem;

// Forward declaration.
@class ITLibPlaylist;

// Forward declaration.
@class ITLibArtwork;

// Forward declaration.
@class ITLibLibraryData;

/*!
    @enum           ITLibExportFeature
    @abstract       These constants describe the features supported by a given iTunes library.
    @constant       ITLibExportFeatureNone
                        No features are supported
*/
enum
{
    ITLibExportFeatureNone    = 0
};

typedef NSUInteger ITLibExportFeature;
 
/*! 
	@abstract A class representing an iTunes library whose metadata is being queried.
*/
ITLIB_EXPORT @interface ITLibrary : NSObject
{
	void * _impl;
}

/*! @abstract The version of iTunes being accessed. */
@property (nonatomic, readonly, copy) NSString* applicationVersion;

/*! @abstract A bitwise OR combination of the features of this library. */
@property (nonatomic, readonly, assign) ITLibExportFeature features;

/*! @abstract The major version number of this API. */
@property (nonatomic, readonly, assign) NSUInteger apiMajorVersion;

/*! @abstract The minor version number of this API. */
@property (nonatomic, readonly, assign) NSUInteger apiMinorVersion;

/*! @abstract The location of the iTunes music folder. */
@property (nonatomic, readonly, copy) NSURL* musicFolderLocation;

/*! @abstract Whether to show content rating labels. */
@property (nonatomic, readonly, assign, getter = shouldShowContentRating) BOOL showContentRating;

/*! @abstract All media items in the library. */
@property (nonatomic, readonly, retain) NSArray* allMediaItems;

/*! @abstract All playlists in the library. */
@property (nonatomic, readonly, retain) NSArray* allPlaylists;

/*!
	@abstract Creates and initializes an instance of ITLibrary which can be used to retrieve media entities.
	@discussion Upon initialization of the ITLibrary class, the default iTunes database for the current user will be read and parsed. 
				At this point all media entities will be cached in memory until the time the object is deallocated.
	@param requestedAPIVersion The version of the iTunesLibrary API that the application is requesting, provide "1.0" if unknown.
	@param error A pointer to a variable that will receive an NSError if this method fails. May be nil if caller does not care about error.
	@return An ITLibrary instance, or nil if this method fails.
 */
+ (id) libraryWithAPIVersion:(NSString*)requestedAPIVersion error:(NSError **)error;

/*!
	@abstract Initializes an instance of ITLibrary which can be used to retrieve media entities.
	@discussion Upon initialization of the ITLibrary class, the default iTunes database for the current user will be read and parsed. 
				At this point all media entities will be cached in memory until the time the object is deallocated.
	@param requestedAPIVersion The version of the iTunesLibrary API that the application is requesting, provide "1.0" if unknown.
	@param error A pointer to a variable that will receive an NSError if this method fails. May be nil if caller does not care about error.
	@return An ITLibrary instance, or nil if this method fails.
 */
- (id) initWithAPIVersion:(NSString*)requestedAPIVersion error:(NSError **)error;

/*! 
	@abstract Retrieves the artwork from a media file. 
	@param mediaFileURL The URL of the media file whose artwork should be extracted.
	@return A ITLibArtwork instance represeting the media file artwork, or nil if the artwork was not found or could not be extracted.
 */
- (ITLibArtwork*) artworkForMediaFile:(NSURL*)mediaFileURL;

/*!
	@abstract Refreshes the data used by the framework.
	@return YES if the data was reloaded, false if an error occurred.
 */
- (BOOL) reloadData;

@end
