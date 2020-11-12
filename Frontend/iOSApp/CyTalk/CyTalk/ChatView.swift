//
//  ChatView.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/11/20.
//

import SwiftUI

struct ChatView: View {
    @State private var message = ""
    @StateObject private var model = ChatSession()

    private func onAppear() {
            model.connect()
        }
    private func onDis(){
        model.disconnect()
    }
    
    var body: some View {
        VStack {
            // Chat history.
            ScrollView { // 1
                // Coming soon!
            }

            // Message field.
            HStack {
                TextField("Message", text: $message) // 2
                    .padding(10)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(5)
                
                Button(action: {}) { // 3
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.system(size: 20))
                }
                .padding()
                .disabled(message.isEmpty) // 4
            }
            .padding()
        }
        
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDis)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
