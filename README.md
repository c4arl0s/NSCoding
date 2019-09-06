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

# Create a swift class 

``` swift
//
//  UglyPersonData.swift
//  NSCodingProject
//
//  Created by Carlos Santiago Cruz on 9/4/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

import UIKit

class UglyPersonData: NSObject {

}
```

# Conform NSCoding protocol

``` swift
//
//  UglyPersonData.swift
//  NSCodingProject
//
//  Created by Carlos Santiago Cruz on 9/4/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

import UIKit

class UglyPersonData: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        <#code#>
    }
    
    required init?(coder aDecoder: NSCoder) {
        <#code#>
    }
    

}
```

# There are two approaches to persis data

- To the Local File System
- NSUserDefaults




