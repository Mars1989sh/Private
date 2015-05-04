//
//  PrivateDB.h
//  Private
//
//  Created by Mars on 14/11/12.
//  Copyright (c) 2014年 MarsZhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabase+Package.h"
#import "SynthesizeSingletonArc.h"


@class RBLoadingAlertView;

@protocol DBDelegate<NSObject>
@end

@interface PrivateDB : NSObject
{
    FMDatabase *_db;
}
SYNTHESIZE_SINGLETON_HEADER(PrivateDB);
@property (nonatomic, weak) id<DBDelegate> DBDelegate;
-(void)start;
-(void)close;
-(NSMutableDictionary*)selectOneWith :(NSInteger)rid;
-(NSMutableArray*)selectCategoryWith :(NSInteger)categoryId;
-(NSMutableArray*)selectAll;
-(void)insertWith:(NSDictionary*) dests;
-(void)updateWith:(NSDictionary*) dests index:(NSInteger)index;
-(void)deleteWithIndex:(NSInteger)index;
-(void)moveIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
@end
