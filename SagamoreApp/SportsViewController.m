//
//  SportsViewController.m
//  SagamoreApp
//
//  Created by Daniel Katz on 4/28/16.
//  Copyright © 2016 Stratton Design. All rights reserved.
//

#import "SportsViewController.h"

@interface SportsViewController (){
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
    NSDateFormatter *formatter;
    NSArray *itemsToDisplay;
}
@property (nonatomic, strong) UIImageView* titleView;

@end

@implementation SportsViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        UIImage *logo = [UIImage imageNamed:@"sports.png"];
        logo = [logo imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _titleView = [[UIImageView alloc] initWithImage:logo];
        self.navigationItem.titleView = _titleView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *logo = [UIImage imageNamed:@"sports.png"];
    logo = [logo imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _titleView = [[UIImageView alloc] initWithImage:logo];
    self.navigationItem.titleView = self.titleView;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    parsedItems = [[NSMutableArray alloc]init];
    
    NSURL *feedURL = [NSURL URLWithString:@"http://thesagonline.com/category/news/feed"];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];
    // Do any additional setup after loading the view.
}

- (void)feedParserDidStart:(MWFeedParser *)parser{
    
    [parsedItems removeAllObjects];
    
    NSLog(@"feedParserDidStart");
    
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info{
    
    NSLog(@"didParseFeedInfo");
    
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item{
    
    NSLog(@"didParseFeedItem");
    
    [parsedItems addObject:item];
    
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
    
    [self.tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [itemsToDisplay count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"newscell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"newscell"];
    }
    cell.tag = indexPath.row;
    
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:1];
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:2];
    
    UILabel *authorLabel = (UILabel *)[cell.contentView viewWithTag:3];
    
    UILabel *dateLabel = (UILabel *)[cell.contentView viewWithTag:4];
    
    MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    if (item) {
        
        // Process
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        
        // Set
        titleLabel.text = itemTitle;
        NSMutableString *subtitle = [NSMutableString string];
        if (item.date) [subtitle appendFormat:@"%@", [formatter stringFromDate:item.date]];
        dateLabel.text = subtitle;
        
        NSString *itemAuthor = item.author ? [item.author stringByConvertingHTMLToPlainText] : @"[No Author]";
        authorLabel.text = itemAuthor;
        
        NSString *htmlContent = item.content;
        NSString *imgSrc;
        
        // find match for image
        NSRange rangeOfString = NSMakeRange(0, [htmlContent length]);
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(<img.*?src=\")(.*?)(\".*?>)" options:0 error:nil];
        
        if ([htmlContent length] > 0) {
            NSTextCheckingResult *match = [regex firstMatchInString:htmlContent options:0 range:rangeOfString];
            if (match != NULL ) {
                NSString *imgUrl = [htmlContent substringWithRange:[match rangeAtIndex:2]];
                //NSLog(@"url: %@", imgUrl);
                imageView.image = nil;
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imgUrl]];
                    if ( data == nil )
                        return;
                    imageView.image = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(cell.tag == indexPath.row) {
                            imageView.image = [UIImage imageWithData: data];
                        }
                        // WARNING: is the cell still using the same data by this point??
                    });
                });
                
                //NSLog(@"match %@", match);
                if ([[imgUrl lowercaseString] rangeOfString:@"feedburner"].location == NSNotFound) {
                    imgSrc = imgUrl;
                }
            }
        }
        
    }
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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