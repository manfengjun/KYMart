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
/**
 查询所有省份

 @return return value description
 */
- (NSMutableArray *)queryAllProvince;

/**
 查询下一级菜单

 @param level level description
 @param parent_id parent_id description
 @return return value description
 */
- (NSMutableArray *)queryDataWith:(NSString *)level parent_id:(NSString *)parent_id;

/**
 根据id查询名称

 @param id id description
 @return return value description
 */
- (NSMutableArray *)queryDataWith:(NSInteger)id;
@end
