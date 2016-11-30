//
//  SearchParameters.h
//  Midterm
//
//  Created by Suvan Ramani on 2016-11-29.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface SearchParameters : NSObject

@property (nonatomic, strong) NSDictionary *placesOfInterest;
@property (nonatomic, strong) NSMutableArray *placeTypeArray;
@property (nonatomic, strong) GMSPath *path;

@end
