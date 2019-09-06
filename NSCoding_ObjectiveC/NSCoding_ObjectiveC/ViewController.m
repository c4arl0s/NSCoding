//
//  ViewController.m
//  NSCoding_ObjectiveC
//
//  Created by Carlos Santiago Cruz on 9/4/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"

@interface ViewController ()
{
    Note *note;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    note = [[Note alloc] init];
    
    note.title = @"Contacto";
    note.author = @"Carl Sagan";
    note.isPublished = YES;
    
    NSLog(@"object to archived: %@", note);
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
        NSLog(@"This is your first write to file sucessed");
    }
    else {
        NSLog(@"There is a proble when it tries to save");
    }
    
    // Unarchiving object
    
    NSMutableData *newMutableData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error = nil;
    NSKeyedUnarchiver *keyedUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:newMutableData error:&error];
    if (!error) {
        NSLog(@"Everything is ok");
        Note *newNote = [keyedUnarchiver decodeObjectForKey:@"NoteObject"];
        if (newNote) {
            NSLog(@"this is the unarchive object: %@", newNote);
        }
        else
        {
            NSLog(@"There is nothing into the object: %@", newNote);
        }
        
    }
    else {
        NSLog(@"There is an error: %@", error.localizedDescription);
    }
    [keyedUnarchiver finishDecoding];
}


@end
