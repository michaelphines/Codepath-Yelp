//
//  SortByCell.m
//  Yelp
//
//  Created by Michael Hines on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SortByCell.h"
#import "YelpClient.h"

@interface SortByCell ()

- (IBAction)sortByChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortByControl;
@property (strong, nonatomic) NSArray *sortByOptions;

@end

@implementation SortByCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.sortByOptions = @[@(YelpSortModeBestMatched), @(YelpSortModeDistance), @(YelpSortModeHighestRated)];
}

- (void)setSortMode:(NSNumber *)sortMode {
    _sortMode = sortMode;
    self.sortByControl.selectedSegmentIndex = [self.sortByOptions indexOfObject:sortMode];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)sortByChanged:(id)sender {
    [self.delegate sortByCell:self didUpdateValue:self.sortByOptions[self.sortByControl.selectedSegmentIndex]];
}
@end
