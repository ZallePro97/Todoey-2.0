//
//  Category.swift
//  Todoey 2.0
//
//  Created by Zeljko Halle on 16/09/2018.
//  Copyright © 2018 Zeljko Halle. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    
    let items = List<Item>()
}
