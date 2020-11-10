//
//  Comment.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/8/20.
//

import Foundation

final class Comment: NSObject {
    let content: String?
    let date: String?
    let name: String?
    let at: String?
    let isInitialized: Bool?
    
    init(content: String?,
         date: String?, name: String?, at: String?, initialized: Bool?) {
        self.content = content
        self.date = date
        self.name = name
        self.at = at
        self.isInitialized = initialized
    }
}