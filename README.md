# NSCoding

NSCoding 

- A protocol that enables an object to be encoded and decoded for achiving and distribution.

# There are many ways to Save data to disk in iOS

- Raw file APIS
- Property List Serialization
- Core data
- Third party solutions like Realm.
- .. and of course NSCoding.

You can convert any object to NSData with the NSCoding protocol.

# There are two approaches to persis data

- To the Local File System
- NSUserDefaults

# Local File System

# NSUserDefaults

# Create a Note class

# Note.h

``` objective-c
//
//  Note.h
//  NSCoding_ObjectiveC
//
//  Created by Carlos Santiago Cruz on 9/4/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject <NSCoding> {
    NSString *title;
    NSString *author;
    BOOL isPublished;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *author;
@property (nonatomic) BOOL isPublished;

@end

NS_ASSUME_NONNULL_END
```

# Note.m

``` objective-c
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
    [coder encodeBool:self.isPublished forKey:@"isPublished"];
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
```


# ViewController.m

``` objective-c
//
//  ViewController.m
//  NSCoding_ObjectiveC
//
//  Created by Carlos Santiago Cruz on 9/4/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"

#define IOS10_OR_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0

@interface ViewController ()
{
    Note *note;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    note = [[Note alloc] init];
    
    note.title = @"Daily note";
    note.author = @"Carlos Santiago";
    note.isPublished = YES;
    
    NSLog(@"object to archive: %@", note);
    
    // Archiving
    NSMutableData *mutableData = [[NSMutableData alloc] init];
    NSKeyedArchiver *keyedArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    [keyedArchiver encodeObject:note forKey:@"NoteObject"];
    [keyedArchiver finishEncoding];
    
    // create the paths
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringDocumentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [stringDocumentsDirectoryPath stringByAppendingPathComponent:@"notes.plist"];
    
    // write to file
    BOOL success = [mutableData writeToFile:filePath atomically:YES];
    if (success) {
        NSLog(@"This is your first write-to-file success");
    }
    else {
        NSLog(@"There is a problem when it tries to save");
    }
    
    if (IOS10_OR_LATER) {
        NSLog(@"This iOS versions is above 12.0");
    }
    else
    {
        NSMutableData *newMutableData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *keyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:newMutableData];
        Note *newNote = [keyedUnarchiver decodeObjectForKey:@"NoteObject"];
        if (newNote) {
            NSLog(@"this is the unarchive object: %@", newNote);
            NSLog(@"this is the unarchive object: %@", newNote.title);
            NSLog(@"this is the unarchive object: %@", newNote.author);
            NSLog(@"this is the unarchive object: %d", newNote.isPublished);
        }
        else
        {
            NSLog(@"There is nothing into the object: %@", newNote);
        }
        [keyedUnarchiver finishDecoding];
    }
    
}


@end
```

# Console

``` console
2019-09-06 13:40:01.842355-0500 NSCoding_ObjectiveC[20808:3195966] object to archive: <Note: 0x60c0000398c0>
2019-09-06 13:40:01.908351-0500 NSCoding_ObjectiveC[20808:3195966] This is your first write-to-file success
2019-09-06 13:40:09.145450-0500 NSCoding_ObjectiveC[20808:3195966] this is the unarchive object: <Note: 0x60c000039140>
2019-09-06 13:40:09.145618-0500 NSCoding_ObjectiveC[20808:3195966] this is the unarchive object: Daily note
2019-09-06 13:40:09.145709-0500 NSCoding_ObjectiveC[20808:3195966] this is the unarchive object: Carlos Santiago
2019-09-06 13:40:09.145788-0500 NSCoding_ObjectiveC[20808:3195966] this is the unarchive object: 1
```
