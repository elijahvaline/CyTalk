//
//  Post.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/20/20.
//

import Foundation


final class Post: NSObject {
    let content: String?
    let date: String?
    let name: String?
    let at: String?
    let isInitialized: Bool?
    let pId:Int?
    
    init(content: String?,
         date: String?, name: String?, at: String?, initialized: Bool?, pId:Int) {
        self.content = content
        self.date = date
        self.name = name
        self.at = at
        self.isInitialized = initialized
        self.pId = pId
    }
}

