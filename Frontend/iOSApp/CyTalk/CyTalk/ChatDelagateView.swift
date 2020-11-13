//
//  ChatDelagateView.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/12/20.
//

import SwiftUI

struct ChatDelagateView: View {
    @State var newChat:String = ""
    @Environment(\.presentationMode) public var presentationMode: Binding<PresentationMode>
    @ObservedObject public var systemUser:User
    @State var chats: [Chat] = [Chat(groupID: -1, initialized: false, user1: "String", user2: "String", username1: "String", username2: "String")]
    var body: some View {
        
        return NavigationView {
            VStack(spacing:0){
                HStack(spacing: 75){
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 30))
                            
                            .foregroundColor(Color("Color2"))
                        
                    }
                    .padding(.leading, 35)
                    
                    
                    Image("smallLogo")
                    Spacer()
                    
                }
                .padding(.bottom, 10)
//                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    
                ScrollView{
                    HStack{
       
                            TextField("Who would you like to chat with?", text: $newChat)
                                .padding(10)
                                .background(Color.secondary.opacity(0.2))
                                .cornerRadius(10)
                            
                        Button(action: {
                            
                        }) {
                            Image(systemName: "paperplane")
                                .font(.system(size: 30))
                                .padding(6)
                                .foregroundColor(Color("Color2"))
                        }
                        .cornerRadius(5)
                        .disabled(newChat.isEmpty)
                        .hoverEffect(.highlight)
                        
                    }
                    .navigationBarHidden(true)
                    
                    .padding()
                    
                    Divider()
                    
                    
                    VStack(spacing: 10) {
                        
                        if chats[0].isInitialized! {
                            ForEach(chats, id: \.self) { chat in
                                
                                NavigationLink(destination: ChatView(systemUser: systemUser, ID: chat.ID!, name1: chat.name1!, name2: chat.name2!, user1: chat.uname1!, user2: chat.uname2!)) {
                                    HStack{
                                        Image(systemName: "person.crop.circle")
                                            .imageScale(.large)
                                            .font(.system(size: 40))
                                            .foregroundColor(Color("Color2"))
                                        
                                        VStack{
                                            Text(chat.name1!)
                                                .font(.system(size:25))
                                                .fontWeight(.light)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                                .foregroundColor(.black)
                                            
                                            Text(chat.uname1!)
                                                .fontWeight(.light)
                                                .foregroundColor(.gray)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            
                                        }.frame(alignment: .leading)
                                        
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 15)
                                    .padding(.bottom, 5)
                                }
//                                .padding(.horizontal, 15)
                           
                
                                Divider()
                                
                                
                            }
                            
                        }
    
                        
                    }
                    
                }
                    
          
                Divider()
                    .padding(.bottom, 10)

                Spacer()
                
                
             
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .onAppear(){
            updateChats()
            
        }
        
    }
    
    
    func updateChats() {
        ServerUtils.getChats(userName: systemUser.username, returnWith:  { response, success in
            if (!success) {
                
                // Show error UI here
                print("OH NO IT FAILED")
                return;
            }
            
            
            let chatSet:[SingleChat] = response!
            
            
            
            var curChat:SingleChat
            
            // Cant modify state variable directly multiple times without swiftui class
            var tempChat:[Chat] = []
            for fish in chatSet {
                
                curChat = fish
            
                let name2:String
                let userName2:String
                let name1:String
                let userName1:String
                
                if (curChat.users[0].uname == systemUser.username){
                    name2 = curChat.users[0].fname + " " + curChat.users[0].lname
                    userName2 = curChat.users[0].uname
                    name1 = curChat.users[1].fname + " " + curChat.users[1].lname
                    userName1 = curChat.users[1].uname
                }
                else{
                    name2 = curChat.users[1].fname + " " + curChat.users[1].lname
                    userName2 = curChat.users[1].uname
                    name1 = curChat.users[0].fname + " " + curChat.users[0].lname
                    userName1 = curChat.users[0].uname
             
                }
               
                
                
                
                          tempChat.append(Chat(groupID: curChat.groupId, initialized: true, user1: name1, user2: name2, username1: userName1, username2: userName2))
                
            }
            
            // Copy array over
            tempChat.reverse()
            self.chats = tempChat
            
        })
    }
}

