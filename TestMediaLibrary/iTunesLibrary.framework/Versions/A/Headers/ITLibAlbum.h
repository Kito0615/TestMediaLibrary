/*!
	@header
	@copyright 2012 Apple Inc.
 */

#import <Foundation/Foundation.h>
#import <iTunesLibrary/ITLibDefines.h>

// Forward declaration.
@class ITLibArtist;

/*! @abstract The ITLibAlbum class represents an album where a given media item (ITLibMediaItem) is contained. */
ITLIB_EXPORT @interface ITLibAlbum : NSObject
{
	NSString* _title;
	NSString* _sortTitle;
	BOOL _compilation;
	NSUInteger _discCount;
	NSUInteger _discNumber;
	NSInteger _rating; 
	BOOL _ratingComputed;
	BOOL _gapless;
	NSUInteger _trackCount;
	NSString* _albumArtist;
	NSString* _sortAlbumArtist;
}

/*! @abstract The name of this album. */
@property (readonly, nonatomic, copy) NSString* title;

/*! @abstract The name of this that should be used for sorting purposes. */
@property (readonly, nonatomic, copy) NSString* sortTitle;

/*! @abstract Whether this album is a compilation. */
@property (readonly, nonatomic, assign, getter = isCompilation) BOOL compilation;

/*! @abstract Deprecated. Will be removed in future versions. */
@property (readonly, nonatomic, retain) ITLibArtist* artist DEPRECATED_ATTRIBUTE;

/*! @abstract The number of discs in this album. */
@property (readonly, nonatomic, assign) NSUInteger discCount;

/*! @abstract The index (i.e. 1, 2, 3, etc.) of the disc this album refers to within a compilation. */
@property (readonly, nonatomic, assign) NSUInteger discNumber;

/*! @abstract The rating of this track's album. */
@property (readonly, nonatomic, assign) NSInteger rating; 

/*! @abstract The rating of this track's album. */
@property (readonly, nonatomic, assign, getter = isRatingComputed) BOOL ratingComputed;

/*! @abstract Whether this track's album is gapless. */
@property (readonly, nonatomic, assign, getter = isGapless) BOOL gapless;

/*! @abstract Number of tracks in this album. */
@property (readonly, nonatomic, assign) NSUInteger trackCount;

/*! @abstract The artist associated with this album. */
@property (readonly, nonatomic, copy) NSString* albumArtist;

/*! @abstract The artist associated with this album. This field should be used when sorting. */
@property (readonly, nonatomic, copy) NSString* sortAlbumArtist;

@end
