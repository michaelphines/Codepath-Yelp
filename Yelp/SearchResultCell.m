//
//  SearchResultCell.m
//  Yelp
//
//  Created by Michael Hines on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
