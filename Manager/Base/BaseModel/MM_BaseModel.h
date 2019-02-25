//
//  MM_BaseModel.h
//  Manager
//
//  Created by devfalme on 2018/12/17.
//  Copyright © 2018 devfalme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface MM_BaseModel : NSObject

- (instancetype)initWithDict:(NSDictionary *)dict;
- (NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
