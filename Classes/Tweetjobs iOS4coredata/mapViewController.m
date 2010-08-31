//
//  clientMapsViewController.m
//  iRecruit-2
//
//  Created by Nicholas Burns on 13/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//



#import "mapViewController.h"


@implementation mapViewController 
@synthesize siteArray, placemark;
//mainTweetArray

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super viewDidLoad];

	
	self.title = @"tod";

	mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds]; 
	
	mapView.mapType = MKMapTypeHybrid;

	mapView.scrollEnabled=TRUE;
	
	mapView.zoomEnabled=TRUE;
	
	mapView.delegate=self;
	
	self.view = mapView;
	


	[self dropPins];


	
}



- (void)viewDidAppear:(BOOL)animated {

	

	if(mapView.delegate == nil){
	mapView.delegate = self;
	}
	
	
	
}

-(void)viewWillAppear:(BOOL)animate {

	
}




- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	MapAnnotation *annotation = view.annotation;
  
	
	if ([annotation title]==@"Todmorden Station herbs") {

		UIAlertView *instructions = [[UIAlertView alloc] initWithTitle:@"ieTod" 
															   message:@"something interesting"
															  delegate:nil 
													 cancelButtonTitle:@"OK" 
													 otherButtonTitles:nil];
		[instructions show];
		[instructions release];
		
		return;
	}
	
	
// push a new view controller here or something else amazing


}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
	for (MKPinAnnotationView *mkaview in views)
	{
		mkaview.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		
		UIImage *origimage = [UIImage imageNamed:@"tod"]; // use png files, read about @2x for retina display

		mkaview.leftCalloutAccessoryView = [[[UIImageView alloc] initWithImage:origimage] autorelease];
	}
	
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{

	MKPinAnnotationView *pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"tod"] autorelease];
	

	pinView.canShowCallout = YES;
	pinView.animatesDrop = TRUE;
	pinView.calloutOffset = CGPointMake(-8, 0);
	
	if ([annotation title]==@"handle exceptions here") {
		[pinView setPinColor:MKPinAnnotationColorPurple]; // or something more stylish
	}
	return pinView;
}


- (void) dropPins
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		

	NSString *fullURL = @"http://maps.google.com/maps/ms?ie=UTF8&source=embed&msa=0&output=georss&msid=103808426177386578886.00046a35298be4d1c56ba";
	
	NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fullURL]];
	
	TreeNode *root = [[XMLParser sharedInstance] parseXMLFromData:data];
	
	for (TreeNode *node in [root objectsForKey:@"item"])
	{
		
		// extract the coordinates
		NSArray *coords = [[node leafForKey:@"georss:point"] componentsSeparatedByString:@" "];
		if (coords.count < 2) continue;
		CLLocationCoordinate2D coord;
		coord.latitude = [[coords objectAtIndex:6] floatValue];
		coord.longitude = [[coords objectAtIndex:7] floatValue];
		
		MapAnnotation *annotation = [[[MapAnnotation alloc] initWithCoordinate:coord] autorelease];
		
		annotation.title = [node leafForKey:@"title"];
		annotation.subtitle = [node leafForKey:@"guide"];
		[mapView addAnnotation:annotation];

	}
	
	// clean up the root
	[root teardown];

	
	
	mapView.zoomEnabled = YES;
	CLLocationCoordinate2D coord;
  
	coord.latitude = 53.716000;
	coord.longitude = -2.097616;
	
	[mapView setCenterCoordinate:coord zoomLevel:11 animated:YES];

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
}









- (void)viewDidLoad {
    [super viewDidLoad];


	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ieTod.jpg"]];
	
	

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	
}

- (void)viewDidDisappear:(BOOL)animated{

	mapView.delegate = nil;

	
	
}


- (void)dealloc {
    [super dealloc];
	[placemark release];
	placemark = nil;
}


@end
