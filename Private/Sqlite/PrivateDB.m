//
//  PrivateDB.m
//  Private
//
//  Created by Mars on 14/11/12.
//  Copyright (c) 2014年 MarsZhang. All rights reserved.
//

#import "PrivateDB.h"

#define DESTINATION_DB @"Private.db"
#define TABLE @"list"
@interface PrivateDB()
{
    NSMutableArray *_recordDict;
    NSString *_path;
}
@end
@implementation PrivateDB
SYNTHESIZE_SINGLETON(PrivateDB);


-(void)initOnce
{
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbFilePath = [documentDirectory stringByAppendingPathComponent:DESTINATION_DB];
    _db = [FMDatabase databaseWithPath:dbFilePath];
    //为数据库设置缓存，提高查询效率
    [_db setShouldCacheStatements:YES];
    [self start];
    [self loadRecord];
}


-(void)loadRecord
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths    objectAtIndex:0];
    NSLog(@"path = %@",path);
    NSString *filename = _path = [path stringByAppendingPathComponent:@"test.plist"];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO)
    {
        NSFileManager* fm = [NSFileManager defaultManager];
        [fm createFileAtPath:filename contents:nil attributes:nil];
    }
    
    NSArray * dic = [NSArray arrayWithContentsOfFile:filename];
    _recordDict = [[NSMutableArray alloc] initWithArray:dic];
    NSLog(@"dic is:%@",dic);
}

-(void)saveRecordWithArray:(NSArray*)array
{
    [array writeToFile:_path atomically:YES];
}


-(void)start
{
    [_db open];
//    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer primary key,latitude REAL,longitude REAL,displayLabel TEXT,hashId TEXT,extra BLOB)",DESTINATION_TABLE];
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer primary key,title TEXT,username TEXT,password TEXT,passwordhine TEXT,email TEXT,notes TEXT,category integer)",TABLE];
    if ([_db executeUpdate:sql]) {
        //DDLogVerbose(@"CreatedSuccess");
        NSLog(@"CreatedSuccess");
    }else{
        //DDLogVerbose(@"CreatedFailure");
        NSLog(@"CreatedFailure");
    }
    [_db close];
}

-(void)close
{

}

-(NSMutableArray*)selectAll
{
    [_db open];
    FMResultSet *rs= [_db selectTable:TABLE :Nil];
    NSMutableDictionary *dictionary;
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
   // NSMutableArray *array = [[NSMutableArray alloc] init];
    while ([rs next]) {
        dictionary = [NSMutableDictionary dictionaryWithCapacity:10];
        [dictionary setObject:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
        [dictionary setObject:[rs stringForColumn:@"title"] forKey:@"title"];
        [dictionary setObject:[rs stringForColumn:@"username"] forKey:@"username"];
        [dictionary setObject:[rs stringForColumn:@"password"] forKey:@"password"];
        [dictionary setObject:[rs stringForColumn:@"passwordhine"] forKey:@"passwordhine"];
        [dictionary setObject:[rs stringForColumn:@"email"] forKey:@"email"];
        [dictionary setObject:[rs stringForColumn:@"notes"] forKey:@"notes"];
        [dictionary setObject:[rs stringForColumn:@"category"] forKey:@"category"];
        [dict setValue:dictionary forKey:[rs stringForColumn:@"id"]];
    }
    [_db close];
    
    NSMutableArray * result = [[NSMutableArray alloc] initWithCapacity:[dict count]];
    for (int i = 0 ;i<[_recordDict count];++i) {
        NSString *hash = [_recordDict objectAtIndex:i];
        id value = [dict valueForKey:hash];
        if(value)
        {
            [result addObject:value];
        }
        else
        {
            [_recordDict removeObjectAtIndex:i];//purge the indices list if necessary.
            i=i-1;
        }
    }
    return result;

}

-(NSMutableDictionary*)selectOneWith :(NSInteger)rid
{
    [_db open];
//    FMResultSet* rs = [_db executeQuery:[NSString stringWithFormat:@"select * from %@ where hashId=?",TABLE], nil];
    NSDictionary *ArgumentsDict = [[NSDictionary alloc] initWithObjectsAndKeys:@"id",rid, nil];
    FMResultSet *rs= [_db selectTable:TABLE :ArgumentsDict];
    NSMutableDictionary *dictionary;
    while ([rs next]) {
        dictionary = [NSMutableDictionary dictionaryWithCapacity:10];
        [dictionary setObject:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
        [dictionary setObject:[NSNumber numberWithDouble:[rs doubleForColumn:@"title"]] forKey:@"title"];
        [dictionary setObject:[NSNumber numberWithDouble:[rs doubleForColumn:@"text"]] forKey:@"text"];
        break;
    }
    [_db close];
    return dictionary;
}


-(NSMutableArray*)selectCategoryWith :(NSInteger)categoryId
{
    [_db open];
    NSDictionary *ArgumentsDict = [[NSDictionary alloc] initWithObjectsAndKeys:@(categoryId),@"category", nil];
    FMResultSet *rs= [_db selectTable:TABLE :ArgumentsDict];
    NSMutableDictionary *dictionary;
    // NSMutableDictionary* array = [[NSMutableDictionary alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    while ([rs next]) {
        dictionary = [NSMutableDictionary dictionaryWithCapacity:10];
        [dictionary setObject:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:@"id"];
        [dictionary setObject:[rs stringForColumn:@"title"] forKey:@"title"];
        [dictionary setObject:[rs stringForColumn:@"username"] forKey:@"username"];
        [dictionary setObject:[rs stringForColumn:@"password"] forKey:@"password"];
        [dictionary setObject:[rs stringForColumn:@"passwordhine"] forKey:@"passwordhine"];
        [dictionary setObject:[rs stringForColumn:@"email"] forKey:@"email"];
        [dictionary setObject:[rs stringForColumn:@"notes"] forKey:@"notes"];
        [dictionary setObject:[rs stringForColumn:@"category"] forKey:@"category"];
        [array addObject:dictionary];
    }
    [_db close];
    return  array;
}


-(void)moveIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex
{
    id obj = [_recordDict objectAtIndex:fromIndex];
    [_recordDict removeObjectAtIndex:fromIndex];
    [_recordDict insertObject:obj atIndex:toIndex];
    [self saveRecordWithArray:_recordDict];
}


-(void)insertWith:(NSDictionary*) dests
{
    [_db open];
    [_db beginTransaction];
    if ( [_db insertRow:dests toTable:TABLE]) {
        NSInteger rid =  [_db lastInsertRowId];
        NSLog(@" rid %ld",(long)rid);
        [_recordDict insertObject:[NSString stringWithFormat:@"%ld",(long)rid] atIndex:0];
        [self saveRecordWithArray:_recordDict];
    }
    [_db commit];
    [_db close];
}


-(void)updateWith:(NSDictionary*) dests index:(NSInteger)index
{
    [_db open];
    [_db beginTransaction];
    [_db updateRow:dests toTable:TABLE index:index];
    [_db commit];
    [_db close];
}


-(void)deleteWithIndex:(NSInteger)index
{
    [_db open];
    [_db beginTransaction];
    [_db deleteWithTable:TABLE index:index];
    [_db commit];
    [_db close];
}
@end
