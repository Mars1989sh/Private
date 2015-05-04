//
//  FMDatabase+Package.h
//  Rainbow
//
//  Created by Mars on 13-11-25.
//  Copyright (c) 2013年 AutoNavi. All rights reserved.
//

#import "FMDatabase.h"

@interface FMDatabase (Package)

-(FMResultSet*)selectTable:(NSString*)tableName :(NSDictionary*)ArgumentsDict;
-(BOOL)insertRow:(NSDictionary *)row toTable:(NSString *)tablename;
-(BOOL)updateRow:(NSDictionary *)row toTable:(NSString *)tablename where:(NSString*)whereClause params:(NSArray*) whereParams;
-(BOOL)updateRow:(NSDictionary *)row toTable:(NSString *)tablename index:(NSInteger)rowid;
-(BOOL)deleteWithTable:(NSString *)tablename index:(NSInteger)rowid;
@end
