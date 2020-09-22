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

    
    init(content: String?,
         date: String?, name: String?, at: String?) {
        self.content = content
        self.date = date
        self.name = name
        self.at = at
    }
}

