//
//  newPost.swift
//  Expirement_1
//
//  Created by Elijah Valine on 8/29/20.
//  Copyright © 2020 Elijah Valine. All rights reserved.
//

import SwiftUI

struct newPost: View {
    @Binding var posts:[String]
    @State var currentPost = ""
    
    var body: some View {
        VStack(spacing: 30) {
            
            TextField("What shall this post say?", text: $currentPost)
                .padding(.leading)
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
            
            Button(action: {
                self.posts.append(self.currentPost)
                
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
            }
            
        }
        
        
    }
}
//
//struct newPost_Previews: PreviewProvider {
//
//    static var previews: some View {
//        newPost()
//    }
//}
