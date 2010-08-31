/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import "MapAnnotation.h"


@implementation MapAnnotation
@synthesize coordinate;
@synthesize title; 
@synthesize subtitle;


- (id) initWithCoordinate: (CLLocationCoordinate2D) aCoordinate
{
	if (self = [super init]) coordinate = aCoordinate;
	return self;
}

-(void) dealloc
{
	self.title = nil;
	self.subtitle = nil;

	[super dealloc];
}
@end


