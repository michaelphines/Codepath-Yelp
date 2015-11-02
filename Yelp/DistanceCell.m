//
//  DistanceCell.m
//  Yelp
//
//  Created by Michael Hines on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "DistanceCell.h"

@interface DistanceCell () <UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *distanceControl;
@property (strong, nonatomic) NSArray *distancesInMeters;
- (IBAction)distanceChanged:(id)sender;

@end

@implementation DistanceCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.distancesInMeters = @[[NSNull null], @482.8f, @1609.3, @8046.7, @32186.9];
}

- (void)setRadius:(NSNumber *)radius {
    _radius = radius;
    self.distanceControl.selectedSegmentIndex = [self.distancesInMeters indexOfObject:radius];
}

- (IBAction)distanceChanged:(id)sender {
    self.radius = self.distancesInMeters[self.distanceControl.selectedSegmentIndex];
    [self.delegate distanceCell:sender didUpdateValue:self.radius];
}

@end
