//
//  Note.h
//  NSCoding_ObjectiveC
//
//  Created by Carlos Santiago Cruz on 9/4/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject <NSCoding, NSSecureCoding> {
    NSString *title;
    NSString *author;
    BOOL isPublished;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic) BOOL isPublished;

@end

NS_ASSUME_NONNULL_END
