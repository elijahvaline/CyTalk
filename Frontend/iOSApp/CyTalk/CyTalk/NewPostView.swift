//
//  NewPostView.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/21/20.
//

import SwiftUI

struct NewPostView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var postContent:String = ""
    @State var message:String = ""
    @State var showPopUp:Bool = false
    @ObservedObject public var systemUser:User
    @Binding var posts:[Post]
    
    var body: some View {
        VStack{
            HStack(spacing: 130){
                Button(action: {
                           self.presentationMode.wrappedValue.dismiss()
                        }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color("Color2"))
                    .font(.system(size: 30))
                }
                Image(uiImage: systemUser.profile!)
                            .resizable()
                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
//                Image(systemName: "person.crop.circle")
//                    .foregroundColor(Color("Color2"))
//                    .font(.system(size: 50))
                
                Button(action: {
                    ServerUtils.addPost(name: systemUser.name, username: systemUser.username, content: postContent, returnWith: {success in
                        
                        if (!success ){
                            message = "Ope! Having trouble connecting"
                            showPopUp = true
                            print("fail")
                            return
                        }
                        else{
                            showPopUp = true
                            message = "Good to go"
                            print("success")
//                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    })
                    updatePosts()
                    self.presentationMode.wrappedValue.dismiss()
                        }) {
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .foregroundColor(Color("Color2"))
                    .font(.system(size: 30))
                }.accessibility(identifier: "post")
            }
            
            TextField("Whats up?", text: $postContent)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
                .frame(width: 400)
                .accessibility(identifier: "worked")
                

            Spacer()
            if $showPopUp.wrappedValue {
                HStack{
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 30))

                    Text(self.message)
                }
                .padding(.top, 10)
                .padding(.bottom, 20.0)

            }
            
            Divider()
            HStack(spacing: 25){
                Image(systemName: "link")
                    .font(.system(size: 30))
                    .foregroundColor(Color("Color2"))
                    
                Image(systemName: "camera.fill")
                    .foregroundColor(Color("Color2"))
                    .font(.system(size: 30))
                Spacer()
            }.padding(.leading, 15)
            .frame(height: 50)
        
        }
        
        .navigationBarHidden(true)
    }
    
    
    func updatePosts() {
        ServerUtils.getPost(returnWith:  { response, success in
            if (!success) {
                
                // Show error UI here
                print("OH NO IT FAILED")
                return;
            }
            
            
            let postSet:[SinglePost] = response!
            
            
            
            var curPost:SinglePost
            
            // Cant modify state variable directly multiple times without swiftui class
            var tempPost:[Post] = []
            for fish in postSet {
                
                curPost = fish
                
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                let myNSDate = Date(timeIntervalSince1970: curPost.date)
                let todaysDate:String = formatter.string(from: myNSDate)
                let postName:String
                let userName:String
                
                if (curPost.name == nil){
                    postName = "Anon"
                }
                else{
                    postName = curPost.name
                }
                
                if (curPost.userName == nil){
                    userName = "Anon"
                }
                else{
                    userName = curPost.userName
                }
                
                
                tempPost.append(Post(content: curPost.content, date: todaysDate, name: postName, at: userName, initialized:true, pId: curPost.pId, prof:nil, isnil: true))
                
            }
            
            // Copy array over
            tempPost.reverse()
            self.posts = tempPost
            
        })
    }
}
