//
//  FiltersViewController.h
//  Yelp
//
//  Created by Michael Hines on 11/1/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

- (void)filtersViewController:(FiltersViewController *)filtersViewController didUpdateFilters:(NSArray *)filters;
@end

@interface FiltersViewController : UIViewController

@property (strong, nonatomic) id<FiltersViewControllerDelegate> delegate;

@end
