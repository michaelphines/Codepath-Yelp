//
//  DistanceCell.h
//  Yelp
//
//  Created by Michael Hines on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DistanceCell;

@protocol DistanceCellDelegate <NSObject>

- (void)distanceCell:(DistanceCell *)cell didUpdateValue:(NSNumber *)value;

@end

@interface DistanceCell : UITableViewCell

@property (strong, nonatomic) id<DistanceCellDelegate> delegate;
@property (strong, nonatomic) NSNumber *radius;

@end
