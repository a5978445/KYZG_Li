//
//  NewsCellProtocol.h
//  访开源中国
//
//  Created by 李腾芳 on 16/11/9.
//  Copyright © 2016年 李腾芳. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsCellProtocol <NSObject>

@property (nonatomic, strong,readonly) NSAttributedString *attributedTittle;
@property (nonatomic, strong,readonly) NSAttributedString *attributedCommentCount;
@property (nonatomic,strong,readonly) NSAttributedString *timeString;
@property (nonatomic,strong,readonly) NSAttributedString *bodyString;

@end
