//
//  PreferencesViewController.m
//  Midterm
//
//  Created by Suvan Ramani on 2016-11-29.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "PreferencesViewController.h"
#import "PlacesViewController.h"
#import "SearchParameters.h"

@interface PreferencesViewController () <UITableViewDelegate, UITableViewDataSource, goToMapView>

@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSDictionary *placesOfInterest;
@property (nonatomic, strong) NSMutableArray *selectedPlaces;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@end

@implementation PreferencesViewController

static NSString * const kShowListOfDetoursIdentifier = @"showListOfDetours";
static NSString * const kPlacesOfInterestCellIdentifier = @"placesOfInterestCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedPlaces = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.warningLabel.hidden = YES;
    self.placesOfInterest = self.parameters.placesOfInterest;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)goToMapView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.placesOfInterest.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPlacesOfInterestCellIdentifier];
    cell.textLabel.textColor =
    [UIColor colorWithRed:225.0/255.0 green:210.0/255.0 blue:188.0/255.0 alpha:1];
    NSArray *arrayOfKeys = [self.placesOfInterest allKeys];
    arrayOfKeys = [arrayOfKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *cellTitle = arrayOfKeys[indexPath.row];
    cell.textLabel.text = cellTitle;
    
    if ([self.selectedPlaces containsObject:cellTitle]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arrayOfKeys = [self.placesOfInterest allKeys];
    arrayOfKeys = [arrayOfKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    NSString *selectedKey = arrayOfKeys[indexPath.row];
    
    if ([self.selectedPlaces containsObject:selectedKey]) {
        [self.selectedPlaces removeObject:selectedKey];
    } else {
        [self.selectedPlaces addObject:selectedKey];
    }
    [self.tableView reloadData];
}

# pragma mark - Segues

- (IBAction)findButton:(UIButton *)sender {
    if (self.selectedPlaces.count > 0) {
        self.warningLabel.hidden = YES;
        [self performSegueWithIdentifier:kShowListOfDetoursIdentifier sender:self];
    } else {
        self.warningLabel.hidden = NO;
    }
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kShowListOfDetoursIdentifier]) {
        self.parameters.placeTypeArray = [self addSearchablePlaceTypes];
        PlacesViewController *destinationVC = segue.destinationViewController;
        destinationVC.parameters = self.parameters;
        destinationVC.delegate = self;
    }
}

#pragma mark - General Methods

- (NSArray *)addSearchablePlaceTypes {
    NSMutableArray *searchableArray = [NSMutableArray array];
    NSArray *arrayOfKeys = self.selectedPlaces;
    arrayOfKeys = [arrayOfKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for (NSString *key in arrayOfKeys) {
        NSString *valueForSearch = self.placesOfInterest[key];
        [searchableArray addObject:valueForSearch];
    }
    return searchableArray;
}

@end
