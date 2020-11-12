//
//  models.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/11/20.
//

import Foundation

struct SubmittedChatMessage: Encodable {
    let message: String
}

struct ReceivingChatMessage: Identifiable {
    
    let id: UUID
    let message: String
    let user:String
    
    init(content:String, curuser:String){
        id = UUID()
        message = content
        user = curuser
    }
}   
