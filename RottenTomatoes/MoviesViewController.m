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
    [SVProgressHUD showWithStatus:@"loading movies" maskType:SVProgressHUDMaskTypeGradient];
    
    NSString *apiUrlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=7ue5rxaj9xn4mhbmsuexug54&limit=20";
    NSURL *url = [NSURL URLWithString:apiUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                     queue:[NSOperationQueue mainQueue]
                     completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                         
                         self.movies = json[@"movies"];
                         [SVProgressHUD dismiss];
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
    
    NSDictionary *movie = self.movies[indexPath.row];
    NSString *mpaaRating = movie[@"mpaa_rating"];
    NSString *synopsis = movie[@"synopsis"];
    NSURL *posterUrl = [NSURL URLWithString:[movie valueForKeyPath:@"posters.thumbnail"]];

    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = [NSString stringWithFormat:@"%@ %@", mpaaRating, synopsis];
    [cell.posterView setImageWithURL:posterUrl];

    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieCell *cell = sender;
    NSIndexPath *indexPath = [self.movieTable indexPathForCell:cell];
    NSDictionary *movie = self.movies[indexPath.row];
    
    DetailsViewController *detailsVC = [segue destinationViewController];
    detailsVC.movie = movie;
}


@end
