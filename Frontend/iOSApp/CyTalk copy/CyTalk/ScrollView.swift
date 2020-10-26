//
//  ScrollView.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/21/20.
//

import SwiftUI

struct PostsView: View {
    
    @State var posts: [Post] = [Post(content: "stirng", date: "string", name: "string", at: "Strng", initialized: false)]
    @State private var post:[String] = ["First","Second","Third"]
    @State private var refreshCount = 0
    
    var body: some View {
        
        return NavigationView {
            VStack(spacing:0){
                HStack(spacing: 75){
                    
                    NavigationLink(destination: HomeView()) {
                        
                    
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Color2"))
                        .padding(.leading, 30)
                        
                    }.accessibility(identifier: "loginScreen")
                   
                    Image("smallLogo")
                    
                }
                .padding(.bottom, 10)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                ScrollView{
                    
                    VStack(spacing: 0) {
                        
                        if posts[0].isInitialized! {
                        ForEach(posts, id: \.self) { post in
//
//                            NavigationLink(destination: PostCommentView(content: post.content!, date: post.date!, name: po st.name!, handle: post.at!)){
//
//                            }
                            
                            
                                NavigationLink(destination: ProfileView(name: post.name!, handle: post.at!)){
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
                                .padding(.bottom, 0.5)
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
                .navigationBarHidden(true)
                .navigationBarTitle("")
                .navigationBarItems(leading:
                                        
                                        HStack{
                                            Image(systemName: "person.crop.circle")
                                                .imageScale(.large)
                                                .font(.system(size: 25))
                                                .foregroundColor(Color("Color2"))
                                            
                                            Image("logo")
                                                .imageScale(.large)
                                                .padding(.leading, 75)
                                        }
                )
                
                
                Divider()
                    .padding(.bottom, 10)
                HStack{
                    NavigationLink(destination: NewPostView()) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color("Color2"))
                            .font(.system(size: 50))
                    }.accessibility(identifier: "newPostButton")
                }
                .frame(width: 414, height: 50).foregroundColor(.white)
                
                
            }
        }
        .onAppear(){
            updatePosts()
        
        }
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
                
                tempPost.append(Post(content: curPost.content, date: todaysDate, name: curPost.name, at: curPost.at, initialized:true))

            }
            
            // Copy array over
            self.posts = tempPost
            
        })
    }
}




struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
