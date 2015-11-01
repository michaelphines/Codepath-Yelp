//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpBusiness.h"
#import "SearchResultCell.h"
#import "UIImageView+AFNetworking.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *businesses;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTable];
    
    [YelpBusiness searchWithTerm:@"Restaurants"
                        sortMode:YelpSortModeBestMatched
                      categories:@[@"burgers"]
                           deals:NO
                      completion:^(NSArray *businesses, NSError *error) {
                          self.businesses = businesses;
                          [self.searchResultsTableView reloadData];
                          for (YelpBusiness *business in businesses) {
                              NSLog(@"%@", business);
                          }
                      }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell *cell = [self.searchResultsTableView dequeueReusableCellWithIdentifier:@"searchResultCell"];
    YelpBusiness *business = self.businesses[indexPath.row];
    cell.companyNameLabel.text = business.name;
    cell.addressLabel.text = business.address;
    cell.servicesLabel.text = business.categories;
    cell.reviewsCountLabel.text = [NSString stringWithFormat:@"%@ Reviews", business.reviewCount];
    cell.distanceLabel.text = business.distance;
    
    [cell.ratingImageView setImageWithURL:business.ratingImageUrl   ];
    [cell.photoImageView setImageWithURL:business.imageUrl];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (void) setUpTable {
    [self.searchResultsTableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil] forCellReuseIdentifier:@"searchResultCell"];
    self.searchResultsTableView.dataSource = self;
    self.searchResultsTableView.delegate = self;
    self.searchResultsTableView.estimatedRowHeight = 128;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
