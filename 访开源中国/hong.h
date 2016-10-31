//
//  hong.h
//  访开源中国
//
//  Created by 李腾芳 on 16/10/27.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#ifndef hong_h
#define hong_h

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

extern AFURLSessionManager * defaultAPPSessionManager();

#endif /* hong_h */
