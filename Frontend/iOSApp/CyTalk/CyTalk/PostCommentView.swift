//
//  PostCommentView.swift
//  CyTalk
//
//  Created by Elijah Valine on 10/17/20.
//

import SwiftUI

struct PostCommentView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var content:String
    @State var date:String
    @State var name:String
    @State var handle:String
    @State var test:String = ""
    @State var pId:Int
    @State var comments: [Comment] = [Comment(content: "stirng", date: "string", name: "string", at: "Strng", initialized: false, id: 1)]
    @ObservedObject public var systemUser:User
    
    var body: some View {
        
        VStack(spacing: 0){
            HStack(spacing: 75){
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("Color2"))
                        .font(.system(size: 30))
                }.padding(.leading, 30)
                
                Image("smallLogo").padding(.leading, 10)
                
            }
            .padding(.bottom, 5)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            Divider()
            
            HStack{
                Image(systemName: "person.crop.circle")
                    .imageScale(.large)
                    .font(.system(size: 40))
                    .foregroundColor(Color("Color2"))
                
                VStack{
                    Text(name)
                        .font(.system(size:25))
                        .fontWeight(.light)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text(handle)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }.frame(alignment: .leading)
                
                
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.vertical, 5)
            Text(content)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.light)
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
                
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            HStack{
                Text(date)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                    .font(.system(size:20))
                Spacer()
            }
            
            
            Divider()
                .padding(.vertical, 5)
            
            HStack(spacing: 0){
                ZStack{
                    
                    Rectangle()
                        .frame(width: 340, height: 40)
                        .cornerRadius(25)
                        .foregroundColor(Color(UIColor.systemGray5))
                    
                    TextField("What would you like to say?", text: $test)
                        .multilineTextAlignment(.center)
                        .cornerRadius(20)
                        .frame(width: 340, height: 50)
                        
                        .font(.system(size:20))
                        
                        
                        .padding(.horizontal, 20)
                    
                }
                
                Button(action: {
                    addComment(content:self.test)
                    
                }) {
                    Image(systemName: "arrowshape.turn.up.right.fill")
                        .foregroundColor(Color("Color2"))
                        .font(.system(size:30))
                    
                }
                .padding(.leading, -10)
                
            }
            
            Divider()
                //                .padding(.horizontal)
                .padding(.top, 5)
            
            ScrollView{
                
                
                
                VStack(spacing: 5) {
                    if comments.count != 0{
                        if comments[0].isInitialized! {
                            ForEach(comments, id: \.self) { post in
                                //
                                //                            NavigationLink(destination: PostCommentView(content: post.content!, date: post.date!, name: po st.name!, handle: post.at!)){
                                //
                                //                            }
                                
                                
                                
//                                HStack{
//                                    Image(systemName: "person.crop.circle")
//                                        .imageScale(.large)
//                                        .font(.system(size: 15))
//                                        .foregroundColor(Color("Color2"))
//                                    Text(post.name!)
//                                        .foregroundColor(.black)
//
//                                    Text(post.at!)
//                                        .foregroundColor(.gray)
//
//                                    Text(post.date!)
//                                        .foregroundColor(.gray)
//
//
//                                    Spacer()
//
//                                }
                                
                                NavigationLink(destination: ProfileView(name: post.name!, handle: post.at!, systemUser: self.systemUser, isUser: false, isMod: isMod())){
                                    HStack{
                                        Image(systemName: "person.crop.circle")
                                            .imageScale(.large)
                                            .font(.system(size: 15))
                                            .foregroundColor(Color("Color2"))
                                        Text(post.name!)
                                            .foregroundColor(.black)
                                        
                                        Text(post.at!)
                                            .foregroundColor(.gray)
                                        
                                        Text(post.date!)
                                            .foregroundColor(.gray)
                                        
                                        
                                        Spacer()
                                        
                                    }
                                }
                                .accessibility(identifier: post.at!)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom, 1)
                                .padding(.top, 5)
                                .padding(.horizontal, 15)
                                
                               
                                
                                
                                Text(post.content!)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 5)
                                    .padding(.horizontal, 15)
                                    .contextMenu{
                                        if isMod() {
                                            Button("Delete Comment", action: {
                                                deleteComment(id: post.id!)
                                            })
                                        }
                                    }
                                
                                Divider()
                                
                                
                            }
                        }
                    }
                }
            }
            
            Spacer()
                .navigationBarHidden(true)
        }
        .onAppear(){
            updateComments()
            
        }
        
        
    }
    func isMod() -> Bool{
        if (systemUser.type == 1){
            return true
        }
        else{
            return false
        }
        
    }
    
    
    func deleteComment(id:Int){
        ServerUtils.deleteComment(commentId: id, returnWith: { response in
            if (response == 200){
                updateComments()
            }
            else{
                return
            }
        })
        
    }
    
    func addComment(content:String){
        
        ServerUtils.addComment(name: systemUser.name, username: systemUser.username, content: content, postId: self.pId, returnWith: {success in
            
            if (!success ){
                //                message = "Ope! Having trouble connecting"
                //                showPopUp = true
                print("fail")
                return
            }
            else{
                //                showPopUp = true
                //                message = "Good to go"
                print("success")
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    updateComments()
                    self.test = ""
                }
                //                            self.presentationMode.wrappedValue.dismiss()
            }
            
        })
        
    }
    
    func updateComments() {
        ServerUtils.getComments(pId: self.pId, returnWith:  { response, success in
            if (!success) {
                
                // Show error UI here
                print("OH NO IT FAILED")
                return;
            }
            
            
            let commentSet:[SingleComment] = response!
            
            
            
            var curComment:SingleComment
            
            // Cant modify state variable directly multiple times without swiftui class
            var tempComment:[Comment] = []
            for fish in commentSet {
                
                curComment = fish
                
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                let myNSDate = Date(timeIntervalSince1970: curComment.date)
                let todaysDate:String = formatter.string(from: myNSDate)
                let postName:String
                let userName:String
                
                if (curComment.name == nil){
                    postName = "Anon"
                }
                else{
                    postName = curComment.name
                }
                
                if (curComment.userName == nil){
                    userName = "Anon"
                }
                else{
                    userName = curComment.userName
                }
                
                
                tempComment.append(Comment(content: curComment.content, date: todaysDate, name: postName, at: userName, initialized:true, id: curComment.commentId ))
                
            }
            
            // Copy array over
            tempComment.reverse()
            self.comments = tempComment
            
        })
    }
}

//
//struct PostCommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCommentView()
//    }
//}
