//
//  FiltersViewController.h
//  Yelp
//
//  Created by Michael Hines on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YelpClient.h"

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)filtersViewController didUpdateFilters:(NSArray *)filters sortMode:(NSNumber *)sortMode radius:(NSNumber *)radius deals:(BOOL)deals;

@end

@interface FiltersViewController : UIViewController

@property (strong, nonatomic) id<FiltersViewControllerDelegate> delegate;

@end
