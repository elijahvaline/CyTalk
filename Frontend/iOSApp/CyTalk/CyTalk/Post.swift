//
//  Post.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/20/20.
//

import Foundation
import SwiftUI

class Post: NSObject {
    var content: String?
    let date: String?
    let name: String?
    let at: String?
    let isInitialized: Bool?
    let pId:Int?
    var isNull:Bool?
   var profile:UIImage?
    
    init(content: String?,
         date: String?, name: String?, at: String?, initialized: Bool?, pId:Int, prof:UIImage?, isnil:Bool) {
        self.content = content
        self.date = date
        self.name = name
        self.at = at
        self.isInitialized = initialized
        self.pId = pId
        self.profile = prof
        self.isNull = isnil
    }
}

