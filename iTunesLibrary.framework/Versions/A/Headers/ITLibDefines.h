/*!
	@header
	@copyright 2012 Apple Inc.
 */

#ifndef ITLIB_DEFINES_H
#define ITLIB_DEFINES_H

#define ITLIB_EXPORT __attribute__((visibility("default")))

#ifdef __cplusplus
	#define ITLIB_EXTERN		extern "C"
#else
	#define ITLIB_EXTERN		extern
#endif

#endif // ITLIB_DEFINES_H
