//
//  Category.swift
//  TodoList
//
//  Created by t2023-m0062 on 2023/08/31.
//

import Foundation

class Category: Codable {
    var name: String
    var todoList: [Todo] = []
    
    init(name: String) {
        self.name = name
    }
}

var categories: [Category] = []
