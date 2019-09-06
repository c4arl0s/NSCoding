//
//  Note.m
//  NSCoding_ObjectiveC
//
//  Created by Carlos Santiago Cruz on 9/4/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

#import "Note.h"

@implementation Note

@synthesize title;
@synthesize author;
@synthesize isPublished;

// this code is taken from Archives and Serializations Programming Guide, it works !

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.author forKey:@"author"];
    [coder encodeFloat:self.isPublished forKey:@"isPublished"];
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        title = [coder decodeObjectForKey:@"title"];
        author = [coder decodeObjectForKey:@"author"];
        isPublished = [coder decodeBoolForKey:@"isPublished"];
    }
    return self;
}

@end
