//
//  SortByCell.h
//  Yelp
//
//  Created by Michael Hines on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpClient.h"

@class SortByCell;

@protocol SortByCellDelegate <NSObject>

- (void)sortByCell:(SortByCell *)cell didUpdateValue:(NSNumber *)value;

@end

@interface SortByCell : UITableViewCell

@property (strong, nonatomic) id<SortByCellDelegate> delegate;

@property (nonatomic) NSNumber *sortMode;

@end
