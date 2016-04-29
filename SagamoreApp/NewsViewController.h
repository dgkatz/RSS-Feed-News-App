//
//  NewsViewController.h
//  SagamoreApp
//
//  Created by Daniel Katz on 4/28/16.
//  Copyright © 2016 Stratton Design. All rights reserved.
//

#import "NSString+HTML.h"
#import <UIKit/UIKit.h>
#import "MWFeedParser.h"

@interface NewsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MWFeedParserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
