//
//  NewsSync.m
//  SLIIT RMS
//
//  Created by Dihara Wijetunga on 11/30/16.
//  Copyright © 2016 Fidenz. All rights reserved.
//

#import "NewsSync.h"
#import "NewsApi.h"
#import "UserApi.h"
#import "NewsItem.h"
#import "User.h"

@implementation NewsSync
{
    NewsApi* newsAPI;
}

#pragma mark - Public

- (id) init
{
    self = [super init];
    newsAPI = [[NewsApi alloc] init];
    return self;
}

+ (NewsSync *) sharedCenter
{
    static dispatch_once_t once;
    static NewsSync * sharedInstance;
    dispatch_once(&once, ^{ sharedInstance = [[self alloc] init]; });
    return sharedInstance;
}

- (void) startNewsSync
{
    [newsAPI getNews:^(NSDictionary *response, NSError *error)
     {
         [self processNewsResponse:response withError:error];
     }];
}

#pragma mark - Private

- (void) processNewsResponse:(NSDictionary*)response withError:(NSError*)error
{
    if(error != nil)
    {
        if(error.code == 403)
        {
            UserApi* userAPI = [[UserApi alloc] init];
            User* initialUser = (User*)[User all].firstObject;
            [userAPI login:initialUser.email withPassword:initialUser.password withBlock:^(NSDictionary *response, NSError *error)
             {
                 if(error == nil)
                 {
                     if(response != nil)
                     {
                         User* user = [[User alloc] init];
                         user.email = initialUser.email;
                         user.password = initialUser.password;
                         user.apiKey = [response valueForKey:@"data"];
                         
                         [User truncate];
                         [user save];
                         
                         [self startNewsSync];
                     }
                     else
                         [self.delegate onNewsSyncComplete:error];
                 }
                 else
                 {
                     [self.delegate onNewsSyncComplete:error];
                 }
             }];
        }
        else
            [self.delegate onNewsSyncComplete:error];
    }
    else
    {
        if(response != nil)
        {
            [NewsItem truncate];
            
            NSArray* newsList = [response valueForKey:@"news"];
            
            for(NSDictionary* item in newsList)
            {
                NewsItem* newItem = [[NewsItem alloc] init];
                
                newItem.title = [item valueForKey:@"title"];
                newItem.news = [item valueForKey:@"news"];
                newItem.publishedData = [item valueForKey:@"published"];
                
                [newItem save];
            }
            
            [self.delegate onNewsSyncComplete:nil];
        }
        else
            [self.delegate onNewsSyncComplete:error];
    }
}

@end
