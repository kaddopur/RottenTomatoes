//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Jason Huang on 6/12/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "MoviesViewController.h"

@interface MoviesViewController ()

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.movies = [[NSArray alloc] init];
    
    NSString *apiUrlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=7ue5rxaj9xn4mhbmsuexug54&limit=20";
    NSURL *url = [NSURL URLWithString:apiUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                     queue:[NSOperationQueue mainQueue]
                     completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                         
                         self.movies = json[@"movies"];
                         [self.movieTable reloadData];
                     }];

    self.movieTable.dataSource = self;
    self.movieTable.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *movieTableIdentifier = @"MovieCell";
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:movieTableIdentifier];

    if (cell == nil) {
        cell = [[MovieCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:movieTableIdentifier];
    }

    cell.titleLabel.text = [self.movies objectAtIndex:indexPath.row][@"title"];
    
    NSString *mpaaRating = [self.movies objectAtIndex:indexPath.row][@"mpaa_rating"];
    NSString *synopsis = [self.movies objectAtIndex:indexPath.row][@"synopsis"];
    
    cell.synopsisLabel.text = [NSString stringWithFormat:@"%@ %@", mpaaRating, synopsis];

    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
