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
#import "FiltersViewController.h"
#import "SVProgressHud.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, FiltersViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;

@property (strong, nonatomic) NSString *searchText;
@property (strong, nonatomic) NSArray *categoryFilters;
@property (strong, nonatomic) NSArray *businesses;
@property (strong, nonatomic) NSString *nextSearch;
@property (strong, nonatomic) NSNumber *radius;
@property (strong, nonatomic) NSNumber *sortMode;

@property BOOL deals;
@property BOOL searchInProgress;
@property BOOL searchAgain;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchText = @"";
    self.categoryFilters = @[];
    self.radius = nil;
    self.sortMode = YelpSortModeBestMatched;
    self.deals = NO;
    [self setUpTable];
    [self setUpNavigation];
    [self search];
}

- (void)search {
    if (self.searchInProgress) {
        self.searchAgain = YES;
    } else {
        self.searchInProgress = YES;
        [SVProgressHUD show];
        [YelpBusiness searchWithTerm:self.searchText
                            sortMode:[self.sortMode integerValue]
                          categories:self.categoryFilters
                              radius:self.radius
                               deals:self.deals
                          completion:^(NSArray *businesses, NSError *error) {
                              [SVProgressHUD dismiss];
                              self.businesses = businesses;
                              [self.searchResultsTableView reloadData];
                              self.searchInProgress = NO;
                              if (self.searchAgain) {
                                  self.searchAgain = NO;
                                  [self search];
                              }
                          }];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell *cell = [self.searchResultsTableView dequeueReusableCellWithIdentifier:@"searchResultCell"];
    YelpBusiness *business = self.businesses[indexPath.row];
    cell.companyNameLabel.text = business.name;
    cell.addressLabel.text = business.address;
    cell.servicesLabel.text = business.categories;
    cell.reviewsCountLabel.text = [NSString stringWithFormat:@"%@ Reviews", business.reviewCount];
    cell.distanceLabel.text = business.distance;
    
    [cell.ratingImageView setImageWithURL:business.ratingImageUrl];
    [cell.photoImageView setImageWithURL:business.imageUrl];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.searchText = searchBar.text;
    [self search];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    if (![self.searchText isEqualToString:@""] && [searchBar.text isEqualToString:@""]) {
        self.searchText = @"";
        [self search];
    }
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void) setUpNavigation {
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.delegate = self;
    [searchBar sizeToFit];
    self.navigationItem.titleView = searchBar;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters" style:UIBarButtonItemStylePlain target:self action:@selector(onFiltersTap)];
}

- (void)filtersViewController:(FiltersViewController *)filtersViewController didUpdateFilters:(NSArray *)filters sortMode:(NSNumber *)sortMode radius:(NSNumber *)radius deals:(BOOL)deals{
    self.categoryFilters = filters;
    self.sortMode = sortMode;
    self.radius = radius;
    self.deals = deals;
    [self search];
}

- (void) onFiltersTap {
    FiltersViewController *vc = [[FiltersViewController alloc] initWithNibName:@"FiltersViewController" bundle:nil];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    vc.delegate = self;
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)setUpTable {
    [self.searchResultsTableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil] forCellReuseIdentifier:@"searchResultCell"];
    self.searchResultsTableView.dataSource = self;
    self.searchResultsTableView.delegate = self;
    self.searchResultsTableView.estimatedRowHeight = 128;
    self.searchResultsTableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
