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

# There are two approaches to persist an instance of a class.

| Local File System   |      NSUserDefaults      |  
|---------------------|:------------------------:|
    

# Using Local File System

# Steps to persist in Local File System

- write your class
- Implemente protocol NSCoding
- Conform protocol in implementation file.
- Archive
- Create the paths in the file system
- Unarchive to test if you saved correctly.

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
    
    // create an note instance
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
2019-09-09 10:50:05.826753-0500 NSCoding_ObjectiveC[54539:4933080] object to archive: <Note: 0x600000426820>
2019-09-09 10:50:06.050412-0500 NSCoding_ObjectiveC[54539:4933080] This is your first write-to-file success
2019-09-09 10:50:06.050936-0500 NSCoding_ObjectiveC[54539:4933080] this is the unarchive object: <Note: 0x604000220820>
2019-09-09 10:50:06.051057-0500 NSCoding_ObjectiveC[54539:4933080] this is the unarchive object: Daily note
2019-09-09 10:50:11.080812-0500 NSCoding_ObjectiveC[54539:4933080] this is the unarchive object: Carlos Santiago
2019-09-09 10:50:11.080971-0500 NSCoding_ObjectiveC[54539:4933080] this is the unarchive object: 1
```
