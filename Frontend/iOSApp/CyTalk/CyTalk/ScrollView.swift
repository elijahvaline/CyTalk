//
//  ScrollView.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/21/20.
//

import SwiftUI

struct PostsView: View {
    
    @State var posts: [Post] = [Post(content: "stirng", date: "string", name: "string", at: "Strng", initialized: false, pId:0)]
    @State private var post:[String] = ["First","Second","Third"]
    @State private var refreshCount = 0
    @ObservedObject public var systemUser = User()
    
    
    func getDestination() -> AnyView {
        if systemUser.loggedIn {
            return AnyView(ProfileView(name: systemUser.name, handle: systemUser.username, systemUser: systemUser))
            } else {
                return AnyView(HomeView(systemUser: self.systemUser))
            }
        }
    
    // View for navigation
    var body: some View {
        
        return NavigationView {
            VStack(spacing:0){
                HStack(spacing: 75){
                    
//                    NavigationLink(destination: HomeView(systemUser: self.systemUser)) {
                    NavigationLink(destination: getDestination()) {
                    
                        
                        
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
                                
                                
                                NavigationLink(destination: ProfileView(name: post.name!, handle: post.at!, systemUser: self.systemUser)){
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
                                
                                NavigationLink(destination: PostCommentView(content: post.content!, date: post.date!, name: post.name!, handle: post.at!, pId: post.pId!, systemUser: self.systemUser)) {
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
                
                Button(action: {
                    let status = KeyChain.save(key: "Ufde", data: "Eli")
                    print("status: ", status)
                    let receivedData = KeyChain.load(key: "Ufde")
                        print(receivedData)

                    
                }) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color("Color2"))
                        .font(.system(size: 35))
                }.padding(.leading, 30)
                
                Divider()
                
                HStack(){
                    Button(action: {
                        updatePosts()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color("Color2"))
                            .font(.system(size: 35))
                    }.padding(.leading, 30)
                    Spacer()
                    NavigationLink(destination: NewPostView(systemUser: self.systemUser)) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color("Color2"))
                            .font(.system(size: 50))
                    }.accessibility(identifier: "newPostButton")
                    
                    Spacer()
                    NavigationLink(destination: ChatDelagateView(systemUser: self.systemUser)) {
                        Image(systemName: "envelope")
                            .foregroundColor(Color("Color2"))
                            .font(.system(size: 35))
                    }.accessibility(identifier: "pmButton")
                    .padding(.trailing, 30)
                    
                    
                    
                   
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
                
                
                tempPost.append(Post(content: curPost.content, date: todaysDate, name: postName, at: userName, initialized:true, pId: curPost.pId))
                
            }
            
            // Copy array over
            tempPost.reverse()
            self.posts = tempPost
            
        })
    }
}




struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
