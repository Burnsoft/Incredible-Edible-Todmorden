//
//  clientMapsViewController.h
//  iRecruit-2
//
//  Created by Nicholas Burns on 13/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

#import "MKMapView+ZoomLevel.h"
#import "XMLParser.h"
#import "TreeNode.h"




@interface mapViewController : UIViewController < MKMapViewDelegate>{
	
																
	MKMapView *mapView;
	MKPlacemark *placemark;


}

@property (nonatomic, retain) NSMutableArray *siteArray;
@property(nonatomic,retain) MKPlacemark * placemark;


-(void)dropPins;
@end
