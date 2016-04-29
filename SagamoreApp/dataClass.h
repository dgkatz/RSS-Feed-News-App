//
//  dataClass.h
//  Sagamore
//
//  Created by Daniel Katz on 6/11/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MWFeedParser.h"
@interface dataClass : NSObject{
       MWFeedItem *feedItem;
}

@property(strong)MWFeedItem *feedItem;


+(dataClass*)getInstance;

@end
