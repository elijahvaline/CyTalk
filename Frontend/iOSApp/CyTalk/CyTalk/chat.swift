//
//  chat.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/12/20.
//

import Foundation

final class Chat: NSObject {
    
    let ID:Int?
    let isInitialized: Bool?
    let name1:String?
    let name2:String?
    let uname1:String?
    let uname2:String?
    
    
    init(groupID:Int, initialized: Bool?, user1:String?, user2:String?, username1:String?, username2:String?) {
        
        self.ID = groupID
        self.isInitialized = initialized
        name1 = user1
        name2 = user2
        uname1 = username1
        uname2 = username2
        
    }
}
