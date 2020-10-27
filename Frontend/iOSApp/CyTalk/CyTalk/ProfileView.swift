//
//  ProfileView.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/21/20.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var name:String
    @State var handle:String
    @State var posts: [Post] = [Post(content: "stirng", date: "string", name: "string", at: "Strng", initialized: false)]
    
    var body: some View {
        
        
        ZStack{
            
            
            VStack{
                Image("cover")
                    .resizable()
                    .frame(width: 414, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .scaledToFit()
                    .shadow(radius: 5)
                Spacer()
                Text("All Profile information here")
                    .foregroundColor(.gray)
                
            }
            
            
            VStack(spacing: 0){
                ZStack{
                    Image(systemName: "circle.fill")
                        .font(.system(size: 220))
                        .shadow(radius: 5)
                        .foregroundColor(.white)
                    
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 200))
                        .foregroundColor(Color("Color2"))
                }.padding(.top, 150)
                
                Spacer()
                
               
                    Text(name).font(.system(size: 40))
                        .fontWeight(.light)
                        .foregroundColor(.black)
                    Text(handle)
                            .fontWeight(.light)
                        .foregroundColor(Color(UIColor.systemGray))
                        .padding(.bottom, 7)
                    Divider()
                    
                    ScrollView{
                        
                        VStack(spacing: 0) {
                            
                            if posts[0].isInitialized! {
                            ForEach(posts, id: \.self) { post in
    //
    //                            NavigationLink(destination: PostCommentView(content: post.content!, date: post.date!, name: po st.name!, handle: post.at!)){
    //
    //                            }
                                
                                
                                    
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
                                    
                                    .accessibility(identifier: post.at!)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 1)
                                    .padding(.top, 5)
                                    .padding(.horizontal, 15)
                                
                                NavigationLink(destination: PostCommentView(content: post.content!, date: post.date!, name: post.name!, handle: post.at!)) {
                                    Text(post.content!)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 5)
                                }
                                .padding(.horizontal, 15)
                                .accessibility(identifier: post.name!)
    //                            .hidden(!post.isInitialized)
                                
                                
                                
                                Divider()
                                   
                                
                            }
                            
                        }
    //                        .frame(width: 375)
                            
                        }
                        
                    }

                
            }
            
            VStack{
                HStack{
                    
                    Button(action: {
                               self.presentationMode.wrappedValue.dismiss()
                            }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 35))

                        .padding(.top)
                        .padding(.leading, 25)
                    }
                    
                    Spacer()
                    
                }.padding(.leading, 15)
                
                
                
                
                Spacer()
            }.padding(.top, 15)
           
            
            
            
            
            
            
                
        }
        
        .onAppear(){
            updatePosts()
        
        }
        .navigationBarHidden(true)
    }
    
    func updatePosts() {
        ServerUtils.getPostFromUser(username: handle, returnWith:  { response, success in
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
                
                
                tempPost.append(Post(content: curPost.content, date: todaysDate, name: postName, at: userName, initialized:true))

            }
            tempPost.reverse()
            // Copy array over
            self.posts = tempPost
            
        })
    }
}
