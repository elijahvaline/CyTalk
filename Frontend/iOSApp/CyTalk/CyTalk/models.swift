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

struct ReceivingChatMessage: Decodable, Identifiable {
    let date: Date
    let id: UUID
    let message: String
}   
