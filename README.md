# NSCoding

NSCoding 

- A protocol that enables an object to be encoded and decoded for achiving and distribution.

You can't put just any object in a plist. This mainly gets people when they want to put something into NSUserDefaults and get an error 

Plists only support the core types: NSString, NSNumber, NSDate, NSData, NSArray, NSDictionary (and their CF buddies thanks to the toll-free bridge). 

You can convert any object to NSData with the NSCoding protocol.
