//
//  PreferencesViewController.m
//  Midterm
//
//  Created by Suvan Ramani on 2016-11-29.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "PreferencesViewController.h"

@interface PreferencesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *placesOfInterest;
@property (nonatomic, strong) NSMutableArray *selectedPlaces;
@end

@implementation PreferencesViewController

static NSString * const kShowListOfDetoursIdentifier = @"showListOfDetours";
static NSString * const kPlacesOfInterestCellIdentifier = @"placesOfInterestCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.placesOfInterest = @{@"Amusement Parks" : @"amusement_park",
                              @"Aquariums" : @"aquarium",
                              @"Art Galleries" : @"art_gallery",
                              @"Campgrounds" : @"campground",
                              @"Casinos" : @"casino",
                              @"Lodging Services" : @"lodging",
                              @"Museums" : @"museum",
                              @"Parking" : @"parking",
                              @"Malls" : @"shopping_mall",
                              @"Zoos" : @"zoo"};
}

#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.placesOfInterest.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPlacesOfInterestCellIdentifier];
    
    NSArray *arrayOfKeys = [self.placesOfInterest allKeys];
    
    cell.textLabel.text = arrayOfKeys[indexPath.row];
    
    return cell;
}


# pragma mark - Segues

- (IBAction)findButton:(UIButton *)sender {
    [self performSegueWithIdentifier:kShowListOfDetoursIdentifier sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kShowListOfDetoursIdentifier]) {
        // set places of interest on destination VC
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
