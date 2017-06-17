//
//  CitiesDataTool.h
//  ChooseLocation
//
//  Created by Sekorm on 16/10/25.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CitiesDataTool : NSObject
+ (instancetype)sharedManager;
- (void)requestGetData;
//查询出所有的省
- (NSMutableArray *)queryAllProvince;
- (NSMutableArray *)queryDataWith:(NSString *)level parent_id:(NSString *)parent_id;
//根据areaCode, 查询地址
- (NSString *)queryAllRecordWithAreaCode:(NSString *) areaCode;
@end
