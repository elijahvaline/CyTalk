//
//  ContentView.swift
//  Expirement_1
//
//  Created by Elijah Valine on 8/29/20.
//  Copyright © 2020 Elijah Valine. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @State private var post:[String] = ["First","Second","Third"]
    
    var body: some View {
        
        
        NavigationView{
            
            ScrollView {
                VStack(spacing: 20){
                    
                    ForEach(post, id: \.self) { post in
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 50)
                                
                                
                                .stroke(Color(UIColor.systemGray6), lineWidth: 2)
                                //                        .frame(width:screenWidth-25)
                                
                                .frame(width: 350, height: 100)
                                .foregroundColor(Color(UIColor.systemBackground))
                                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
                            
                            Text(String(post))
                                .foregroundColor(.black)
                        }
                        
                        
                        
                    }
                    
                    
                    NavigationLink(destination: newPost(posts: self.$post)){
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 60))
                    }
                    
                    
                    
                }
                .frame(width: 400)
                
                
            }
            
            
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
