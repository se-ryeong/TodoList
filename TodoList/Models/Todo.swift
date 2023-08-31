//
//  Todo.swift
//  TodoList
//
//  Created by t2023-m0062 on 2023/08/31.
//

import Foundation

class Todo: Codable {
    var content: String = ""
    var isCompleted: Bool = false
    
    init(content: String) {
        self.content = content
    }
    
    func updateContent(text: String) {
        self.content = text
    }
}
