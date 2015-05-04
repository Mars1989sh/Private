//
//  FMDatabase+Package.m
//  Rainbow
//
//  Created by Mars on 13-11-25.
//  Copyright (c) 2013年 AutoNavi. All rights reserved.
//

#import "FMDatabase+Package.h"

@implementation FMDatabase (Package)

-(FMResultSet*)selectTable:(NSString*)tableName :(NSDictionary*)ArgumentsDict
{
    FMResultSet *rs;
    NSMutableString* sql = [NSMutableString stringWithFormat:@"SELECT * FROM %@ ",tableName];
    if (ArgumentsDict != Nil) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
        [sql appendString:@"WHERE "];
        int i=1;
        int count = (int)[ArgumentsDict count];
        for(NSString *key in [ArgumentsDict keyEnumerator])
        {
            [sql appendString:key];
            
            if (i == count) {
                [sql appendString:@" = ? "];
            }else{
                [sql appendString:@" = ? AND "];
            }
            [arr addObject:[ArgumentsDict objectForKey:key]];
            i++;
        }
        //[sql appendString:@"ORDER BY orderDate"];
        rs = [self executeQuery:sql withArgumentsInArray:arr];
    }else{
        [sql appendString:@" ORDER BY id DESC "];
        rs = [self executeQuery:sql];
    }
    //NSLog(@"select all : %@",sql);
    return rs;
}



-(BOOL)insertRow:(NSDictionary *)row toTable:(NSString *)tablename
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    NSMutableString *sql = [NSMutableString stringWithString:@"insert into "];
    [sql appendString:tablename];
    [sql appendString:@" ("];
    NSMutableString *strParams = [NSMutableString stringWithString:@" values ("];
    NSInteger index = 0;
    for(NSString *key in [row keyEnumerator])
    {
        if(index > 0){
            [sql appendString:@","];
            [strParams appendString:@","];
        }
        [sql appendString:key];
        [strParams appendString:@"?"];
        [arr addObject:[row objectForKey:key]];
        index ++;
    }
    [sql appendString:@")"];
    [strParams appendString:@")"];
    [sql appendString:strParams];
    //DDLogVerbose(@"sql: %@",sql);
    if ([self executeUpdate:sql withArgumentsInArray:arr]) {
        return YES;
    }else{
        return NO;
    }
}


-(BOOL)updateRow:(NSDictionary *)row toTable:(NSString *)tablename index:(NSInteger)rowid
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    NSMutableString *sql = [NSMutableString stringWithString:@"update "];
    [sql appendString:tablename];
    [sql appendString:@" set "];
    NSInteger index = 0;
    for(NSString *key in [row keyEnumerator])
    {
        if(index > 0) {
            [sql appendString:@","];
        }
        
        [sql appendString:key];
        [sql appendString:@"=?"];
        [arr addObject:[row objectForKey:key]];
        //[sql appendString:[row objectForKey:key]];
        index ++;
        NSLog(@"key:%@",key);
        NSLog(@"value:%@",[row objectForKey:key]);
    }
    [sql appendFormat:@" where id=%ld", (long)rowid];
    NSLog(@"sql: %@",sql);
    
    if ([self executeUpdate:sql withArgumentsInArray:arr]) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)updateRow:(NSDictionary *)row toTable:(NSString *)tablename where:(NSString*)whereClause params:(NSArray*) whereParams
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    NSMutableString *sql = [NSMutableString stringWithString:@"update "];
    [sql appendString:tablename];
    [sql appendString:@" set "];
    NSInteger index = 0;
    for(NSString *key in [row keyEnumerator])
    {
        if(index > 0) {
            [sql appendString:@","];
        }
        
        [sql appendString:key];
        [sql appendString:@"=?"];
        [arr addObject:[row objectForKey:key]];
        index ++;
    }
    [sql appendFormat:@" where %@",whereClause];
    [arr addObjectsFromArray:whereParams];
    //DDLogVerbose(@"sql: %@",sql);
    
    if ([self executeUpdate:sql withArgumentsInArray:arr]) {
        return YES;
    }else{
        return NO;
    }
}


-(BOOL)deleteWithTable:(NSString *)tablename index:(NSInteger)rowid
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:6];
    NSMutableString *sql = [NSMutableString stringWithString:@"delete from "];
    [sql appendString:tablename];
    [sql appendFormat:@" where id=%ld", (long)rowid];
    NSLog(@"sql: %@",sql);
    
    if ([self executeUpdate:sql withArgumentsInArray:arr]) {
        return YES;
    }else{
        return NO;
    }
}


@end
