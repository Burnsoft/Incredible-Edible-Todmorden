//
//  MKMapView+ZoomLevel.h
//  Burnsoft RSS News Reader
//
//  Created by Nicholas Burns on 11/05/2010.
//  Copyright 2010 Burnsoft Ltd. All rights reserved.
//



#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
				  zoomLevel:(NSUInteger)zoomLevel
				   animated:(BOOL)animated;

@end 