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
    @Published var type = 0
    @Published var profile:UIImage?
    @Published var background:UIImage?
    
    
    
    init(){
        self.username = "anon"
        self.name = "anon"
        
        profile = UIImage(named: "sinuser")
        background = UIImage(named: "cover")
        
        
    }
    
    func logOut(){
        self.username = "anon"
        self.name = "anon"
        loggedIn = false
        type = 0
        profile = UIImage(named: "sinuser")
        background = UIImage(named: "cover")
        
    }
    
}
