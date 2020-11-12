//
//  ChatSession.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/11/20.
//

import Combine
import Foundation

final class ChatSession: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask? // 1
    // MARK: - Connection
    func connect() { // 2
        let url = URL(string: "ws://coms-309-sb-07.cs.iastate.edu:8080/chat/IronM/2")!// 3
//        let url = URL(string: "wss://echo.websocket.org")! // 3
        print(url)
        webSocketTask = URLSession.shared.webSocketTask(with: url) // 4
        webSocketTask?.receive(completionHandler: onReceive) // 5
        webSocketTask?.resume() // 6
            
        
    }
    
    func disconnect() { // 7
        webSocketTask?.cancel(with: .normalClosure, reason: nil) // 8
    }

    private func onReceive(incoming: Result<URLSessionWebSocketTask.Message, Error>) {
        // Nothing yet...
    }
    
    deinit { // 9
        disconnect()
    }
}
