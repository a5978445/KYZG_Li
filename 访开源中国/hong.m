//
//  hong.c
//  访开源中国
//
//  Created by 李腾芳 on 16/10/28.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#include "hong.h"

AFURLSessionManager * defaultAPPSessionManager() {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    [responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer = responseSerializer;
    return manager;
}
