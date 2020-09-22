//
//  ScrollView.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/21/20.
//

import SwiftUI

struct PostsView: View {
    
    @State var posts: [Post] = []
    @State private var post:[String] = ["First","Second","Third"]
    
    var body: some View {
        
        return NavigationView {
            VStack{
                HStack(spacing: 75){
                    
                    NavigationLink(destination: ProfileView()) {
                        
                    
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .font(.system(size: 25))
                        .foregroundColor(Color("Color2"))
                        .padding(.leading, 30)
                    }
                    Image("smallLogo")
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                ScrollView{
                    
                    ForEach(posts, id: \.self) { post in
                        
                        HStack{
                            Image(systemName: "person.crop.circle")
                                .imageScale(.large)
                                .font(.system(size: 15))
                                .foregroundColor(Color("Color2"))
                            Text(post.name!)
                            Text(post.at!)
                                .foregroundColor(.gray)
                            Text(post.date!)
                                .foregroundColor(.gray)
                            Spacer()
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 0.5)
                        
                        Text(post.content!)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                        
                    }.frame(width: 375)//
                    
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
                HStack{
                    NavigationLink(destination: NewPostView()) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color("Color2"))
                            .font(.system(size: 50))
                    }
                }
                .frame(width: 414, height: 50).foregroundColor(.white)
                
                
            }
        }
        .onAppear(){
            ServerUtils.getPost(returnWith:  { response, success in
                if (!success) {
                    
                    // Show error UI here
                    print("OH NO IT FAILED")
                    return;
                }
                
                self.posts.removeAll()
                let postSet:DataSet = response!
                
                
                
                _ = self.posts.count
                
                
                _ = postSet.fish.count
                var curPost:SinglePost
                
                for fish in postSet.fish {
                    
                    curPost = fish
                    
                    let formatter = DateFormatter()
                    formatter.dateStyle = .short
                    let myNSDate = Date(timeIntervalSince1970: curPost.date)
                    let todaysDate:String = formatter.string(from: myNSDate)
                    
                    self.posts.append(Post(content: curPost.content, date: todaysDate, name: curPost.name, at: curPost.at))
                    
                    
                    
                }
                
            })
        }
    }
}


struct ScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
