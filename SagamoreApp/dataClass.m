//
//  dataClass.m
//  Sagamore
//
//  Created by Daniel Katz on 6/11/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "dataClass.h"

@implementation dataClass

@synthesize feedItem;


static dataClass *instance = nil;

+(dataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [dataClass new];
        }
    }
    return instance;
}

@end
