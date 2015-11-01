//
//  SwitchCell.h
//  Yelp
//
//  Created by Michael Hines on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value;

@end

@interface SwitchCell : UITableViewCell

@property (nonatomic) BOOL on;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) id<SwitchCellDelegate> delegate;

@end
