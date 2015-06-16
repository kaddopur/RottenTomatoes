//
//  MoviesViewController.h
//  RottenTomatoes
//
//  Created by Jason Huang on 6/12/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MoviesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *movieTable;

@end
