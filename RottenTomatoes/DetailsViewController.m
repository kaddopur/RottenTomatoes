//
//  DetailsViewController.m
//  RottenTomatoes
//
//  Created by Jason Huang on 6/16/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    
    NSURL *posterUrl = [self toHiResPosterUrl:[self.movie valueForKeyPath:@"posters.thumbnail"]];
    [self.posterView setImageWithURL:posterUrl];
}

- (NSURL *)toHiResPosterUrl:(NSString *)thumbnailUrlString {
    // from: http://resizing.flixster.com/AzO1t1_Eo-lx0HZKeWlazwp3-Fg=/54x80/dkpu1ddg7pbsk.cloudfront.net/movie/11/19/09/11190926_ori.jpg
    // to: http://content6.flixster.com/movie/11/19/09/11190926_ori.jpg

    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"movie.*$" options:0 error:&error];
    NSArray *matches = [regex matchesInString:thumbnailUrlString options:0 range:NSMakeRange(0, thumbnailUrlString.length)];
    NSString *matchText = [thumbnailUrlString substringWithRange:[matches[0] range]];
    NSString *hiResPrefix = @"http://content6.flixster.com/";

    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", hiResPrefix, matchText]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
