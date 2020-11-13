//
//  ChatView.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/11/20.
//

import SwiftUI

struct ChatView: View {
    @State private var message = ""
    @ObservedObject private var model = ChatSession()
    @ObservedObject public var systemUser:User
    @State var ID:Int
    @State var messages:[String] = []
    @State var name1:String
    @State var name2:String
    @State var user1:String
    @State var user2:String


    private func onAppear() {
        model.connect(ID: ID, username: systemUser.username)
            
        }
    private func onDis(){
        model.disconnect()
        messages.removeAll()
    }
    private func onCommit() {
            if !message.isEmpty {
                model.send(text: message)
                message = ""
            }
        }
    private func scrollToLastMessage(proxy: ScrollViewProxy) {
        if let lastMessage = model.messages.last {
            withAnimation(.easeOut(duration: 0.4)) {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }

    var body: some View {
        VStack {
            // Chat history.
           
            ScrollView {
                ScrollViewReader{ proxy in
                    LazyVStack(spacing: 8) {
                        ForEach(model.messages) { message in
                            ChatMessageRow(message: message.message, isUser: message.user == systemUser.username, user: message.user, name1: self.name1, name2: self.name2)
                                .id(message.id)
                        }
                    }
                    .padding(10)
                    .onChange(of: model.messages.count) { _ in
                        scrollToLastMessage(proxy: proxy)
                    }
     
                }
            }

            // Message field.
            HStack {
                TextField("Message", text: $message, onEditingChanged: { _ in }, onCommit: onCommit)
                    .padding(10)
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(5)

                Button(action: onCommit) {
                    Image(systemName: "arrowshape.turn.up.right")
                        .font(.system(size: 20))
                        .padding(6)
                }
                .cornerRadius(5)
                .disabled(message.isEmpty)
                .hoverEffect(.highlight)
            }
            .padding()
        }
        .navigationTitle("Chat")
        .onAppear(perform: onAppear)
        .onDisappear(perform: onDis)
    }
}


private struct ChatMessageRow: View {
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    let message:String
    let isUser: Bool
    let user:String

    let name1:String
    let name2:String
    var body: some View {
        HStack {
            if isUser {
                Spacer()
            }

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(isUser ? name1 : name2)
                        .fontWeight(.bold)
                        .font(.system(size: 12))
                }

                Text(message)
            }
            .foregroundColor(isUser ? .white : .black)
            .padding(10)
            .background(isUser ? Color("Color2") : Color(white: 0.95))
            .cornerRadius(10)

            if !isUser {
                Spacer()
            }
        }
        .transition(.scale(scale: 0, anchor: isUser ? .topTrailing : .topLeading))
    }
}
