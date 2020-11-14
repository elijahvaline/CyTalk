//
//  ChatSession.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/11/20.
//

import Combine
import Foundation
import SwiftUI

final class ChatSession: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask? // 1
        @Published private(set) var messages: [ReceivingChatMessage] = []
//    @Published var messages:String = ""
    
    
    
    // MARK: - Connection
    func connect(ID:Int, username:String) { // 2
        let url = URL(string: "ws://coms-309-sb-07.cs.iastate.edu:8080/chat/" + username + "/" + String(ID))!// 3
        //        let url = URL(string: "wss://echo.websocket.org")! // 3
        print(url)
        webSocketTask = URLSession.shared.webSocketTask(with: url) // 4
        webSocketTask?.receive(completionHandler: onReceive) // 5
        webSocketTask?.resume() // 6
        
        
    }
    
    func disconnect() { // 7
        messages.removeAll()
        webSocketTask?.cancel(with: .normalClosure, reason: nil) // 8
    }
    
    
    
    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        webSocketTask?.receive(completionHandler: onReceive)
        
        if case .success(let message) = incoming {
            onMessage(message: message)
        }
        else if case .failure(let error) = incoming {
            print("Error", error)
        }
    }
    
    private func onMessage(message: URLSessionWebSocketTask.Message) {
        
       
        
        if case .string(let text) = message {
            
//            sman: w* sman: Hi* sman: Test* IronM: WebSocket rocks*
            
            DispatchQueue.main.async {
                
                var username = ""
                var content = ""
                var user = true
                var wasteOne = 0
                for char in text {
                    
                    if (wasteOne == 1){
                        wasteOne = 0
                    }
                    else if (char == ":"){
                        user = false
                        wasteOne = 1
                    }
                    else if (char == "*"){
                        self.messages.append(ReceivingChatMessage(content: content, curuser: username))
                        username = ""
                        content = ""
                        user = true
                        wasteOne = 1
                    }
                    else if (user==true){
                        username = username + String(char)
                    }
                    else if (user == false){
                        content = content + String(char)
                    }
                }
                
                
                
                //                withAnimation(.spring()) {
                //                    self.messages.append(ReceivingChatMessage(content: text, curuser: <#T##String#>))
                
//                self.messages += " " + text
                //                }
            }
        }
    }
    
    
    func send(text: String) {
        
        //        for char in text {
        //
        //
        //        }
        webSocketTask?.send(.string(text)) { error in
            if let error = error {
                print("Error sending message", error)
            }
        }
    }
    
    deinit { // 9
        disconnect()
    }
}
