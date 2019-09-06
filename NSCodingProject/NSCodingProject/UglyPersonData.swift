//
//  UglyPersonData.swift
//  NSCodingProject
//
//  Created by Carlos Santiago Cruz on 9/4/19.
//  Copyright © 2019 Carlos Santiago Cruz. All rights reserved.
//

import UIKit



class UglyPersonData: NSObject, NSCoding {
    
    ///// CORRECT THIS
    
    enum Keys: String {
        case title = "Title"
        case rating = "Rating"
    }
    
    // this is the encoder
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Keys.title, forKey: Keys.title.rawValue)
        aCoder.encode(Keys.rating, forKey: Keys.title.rawValue)
    }
    
    // This is the decoder.
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(title: title, rating: rating)
    }
    

}
