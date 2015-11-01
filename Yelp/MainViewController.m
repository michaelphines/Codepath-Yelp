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

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic) NSArray *businesses;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTable];
    [self setUpSearchBar];
    [self search:@""];
}

- (void)search:(NSString *)searchString {
    [YelpBusiness searchWithTerm:searchString
                        sortMode:YelpSortModeBestMatched
                      categories:@[]
                           deals:NO
                      completion:^(NSArray *businesses, NSError *error) {
                          self.businesses = businesses;
                          [self.searchResultsTableView reloadData];
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

- (void) setUpSearchBar {
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.delegate = self;
    [searchBar sizeToFit];
    self.navigationItem.titleView = searchBar;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self search:searchText];
}

- (void)setUpTable {
    [self.searchResultsTableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil] forCellReuseIdentifier:@"searchResultCell"];
    self.searchResultsTableView.dataSource = self;
    self.searchResultsTableView.delegate = self;
    self.searchResultsTableView.estimatedRowHeight = 128;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
