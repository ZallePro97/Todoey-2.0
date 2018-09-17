//
//  Item.swift
//  Todoey 2.0
//
//  Created by Zeljko Halle on 16/09/2018.
//  Copyright © 2018 Zeljko Halle. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
