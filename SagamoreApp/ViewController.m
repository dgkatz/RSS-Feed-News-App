//
//  ViewController.m
//  SagamoreApp
//
//  Created by Daniel Katz on 4/28/16.
//  Copyright © 2016 Stratton Design. All rights reserved.
//

#import "ViewController.h"
@interface ViewController (){
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
    NSArray *itemsToDisplay;
}
@property (nonatomic, strong) UIImageView* titleView;


@end

@implementation ViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        UIImage *logo = [UIImage imageNamed:@"arts.png"];
        logo = [logo imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _titleView = [[UIImageView alloc] initWithImage:logo];
        self.navigationItem.titleView = _titleView;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *logo = [UIImage imageNamed:@"arts.png"];
    logo = [logo imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _titleView = [[UIImageView alloc] initWithImage:logo];
    self.navigationItem.titleView = self.titleView;
    
    parsedItems = [[NSMutableArray alloc]init];
    
    NSURL *feedURL = [NSURL URLWithString:@"http://thesagonline.com/category/news/feed"];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];

}

- (void)feedParserDidStart:(MWFeedParser *)parser{
    
    NSLog(@"feedParserDidStart");
    
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info{
    
    NSLog(@"didParseFeedInfo");
    
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item{
    
    NSLog(@"didParseFeedItem");
    
    if (item) [parsedItems addObject:item];

}

- (void)feedParserDidFinish:(MWFeedParser *)parser{
    
    NSLog(@"feedParserDidFinish");
    
    [self displayItems];
    
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error{
    
    NSLog(@"%@",error);
    
}

-(void)displayItems{
    
    itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
                           [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO]]];
    
    NSLog(@"rss feed : %@", itemsToDisplay);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
