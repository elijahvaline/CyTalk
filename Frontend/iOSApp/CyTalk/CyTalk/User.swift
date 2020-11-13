//
//  User.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/5/20.
//

import Foundation
import SwiftUI
import Combine

class User: ObservableObject {
    
   @Published var username = ""
    @Published var name = ""
    @Published var loggedIn = false
   
    
    
    init(){
        self.username = "anon"
        self.name = "anon"
        
        
    }
    
    
    
    
    
}
