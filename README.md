# NSCoding

1. [There are many ways to Save data to disk in iOS]()
2. [There are two approaches to persist an instance of a class.]()
3. [Using Local File System]()
4. [Steps to persist in Local File System]()
5. [NSUserDefaults]()



NSCoding_ObjectiveC

- A protocol that enables an object to be encoded and decoded for achiving and distribution.

# 1. [There are many ways to Save data to disk in iOS]()

- Raw file APIS
- Property List Serialization
- Core data
- Third party solutions like Realm.
- .. and of course NSCoding.

You can convert any object to NSData with the NSCoding protocol.

# 2. [There are two approaches to persist an instance of a class.]()

| Local File System   |      NSUserDefaults      |  
|---------------------|:------------------------:|
    

# 3. [Using Local File System]()

# 4. [Steps to persist in Local File System]()

- write your class
- Implemente protocol NSCoding
- Conform protocol in implementation file.
- Archive
- Create the paths in the file system
- Unarchive to test if you saved correctly.

# 5. [NSUserDefaults]()

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

#define IOS12_OR_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0

@interface ViewController ()
{
    Note *note;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create a note instance
    note = [[Note alloc] init];
    
    // stored new values
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
    // In swift we can also create URLs, which is the best way.
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
    
    // Unarchiving
    if (IOS12_OR_LATER) {
        NSLog(@"This iOS versions is or above 12.0");
    }
    else
    {
        NSLog(@"This iOS versions is below 12.0");
        NSMutableData *newMutableData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *keyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:newMutableData];
        Note *unarchivedNote = [keyedUnarchiver decodeObjectForKey:@"NoteObject"];
        if (unarchivedNote) {
            NSLog(@"this is the unarchive object: %@", unarchivedNote);
            NSLog(@"this is the unarchive object: %@", unarchivedNote.title);
            NSLog(@"this is the unarchive object: %@", unarchivedNote.author);
            NSLog(@"this is the unarchive object: %d", unarchivedNote.isPublished);
        }
        else
        {
            NSLog(@"There is nothing into the object: %@", unarchivedNote);
        }
        [keyedUnarchiver finishDecoding];
    }
}


@end
```

# Console

``` console
2019-09-09 10:56:27.789555-0500 NSCoding_ObjectiveC[55025:4938012] object to archive: <Note: 0x604000037600>
2019-09-09 10:56:27.817591-0500 NSCoding_ObjectiveC[55025:4938012] This is your first write-to-file success
2019-09-09 10:56:27.817889-0500 NSCoding_ObjectiveC[55025:4938012] This iOS versions is below 12.0
2019-09-09 10:56:27.818187-0500 NSCoding_ObjectiveC[55025:4938012] this is the unarchive object: <Note: 0x60c000031760>
2019-09-09 10:56:27.818295-0500 NSCoding_ObjectiveC[55025:4938012] this is the unarchive object: Daily note
2019-09-09 10:56:27.818391-0500 NSCoding_ObjectiveC[55025:4938012] this is the unarchive object: Carlos Santiago
2019-09-09 10:56:27.818480-0500 NSCoding_ObjectiveC[55025:4938012] this is the unarchive object: 1

```
