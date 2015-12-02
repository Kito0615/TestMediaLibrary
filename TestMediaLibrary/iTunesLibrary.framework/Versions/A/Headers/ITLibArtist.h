/*!
	@header
	@copyright 2012 Apple Inc.
 */

#import <Foundation/Foundation.h>
#import <iTunesLibrary/ITLibDefines.h>

/*! The ITLibArtist class represents an artist, such as the performer of a song. */
ITLIB_EXPORT @interface ITLibArtist : NSObject
{
	NSString* _name;
	NSString* _sortName;
}

/*! @abstract The name of this artist. */
@property (readonly, nonatomic, copy) NSString* name;

/*! @abstract The name of this artist that should be used for sorting purposes. */
@property (readonly, nonatomic, copy) NSString* sortName;

@end
