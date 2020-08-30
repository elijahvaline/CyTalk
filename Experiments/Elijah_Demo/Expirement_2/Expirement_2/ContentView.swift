//
//  ContentView.swift
//  Expirement_2
//
//  Created by Elijah Valine on 8/29/20.
//  Copyright © 2020 Elijah Valine. All rights reserved.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    let scaleFactor:Float = 0.12
    
    
    func makeBody(configuration: Configuration) -> some View {
        
        return Image(systemName: configuration.isOn ? "arrow.up.circle.fill" : "arrow.up.circle")
            
            .font(.system(size:60))
            .onTapGesture { configuration.isOn.toggle() }
    }
}
struct CheckboxToggleStyleDown: ToggleStyle {
    let scaleFactor:Float = 0.12
    
    
    func makeBody(configuration: Configuration) -> some View {
        
        return Image(systemName: configuration.isOn ? "arrow.down.circle.fill" : "arrow.down.circle")
            
            .font(.system(size:60))
            .onTapGesture { configuration.isOn.toggle() }
    }
}

struct ContentView: View {
    var screenWidth  = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    @State var posts:[String] = ["one", "two", "three", "four", "five", "size", "seven", "eight", "nine", "ten"]
    @State var upvote:Bool = false
    @State var downvote:Bool = false
    
    var body: some View {
        
       let onUp = Binding<Bool>(get: { self.upvote }, set: { self.upvote = $0; self.downvote = false})
              let onDown = Binding<Bool>(get: { self.downvote}, set: { self.upvote = false; self.downvote = $0})
        
        
       return ZStack{
            
//
            
            ScrollView{
                VStack(spacing: 15) {
                    
                    ForEach(posts, id: \.self) { posts in
                        
                       

                            
                            
                            
                            ZStack{
                                
                                
                                Rectangle()
                                    .frame(width: self.screenWidth, height: 200)
                                    .foregroundColor(.white)
                                    .shadow(radius: 5)
                                    .edgesIgnoringSafeArea(.all)
                                
                                HStack(spacing: 50 ){

                                    Toggle(isOn: onUp){
                                        Text("")
                                    }
                                    .toggleStyle(CheckboxToggleStyle())
                                    .foregroundColor(.green)
                                    
                                    Text(posts)
                                    .font(.title)
                                    .foregroundColor(.blue)

                                    Toggle(isOn: onDown){
                                        Text("")
                                    }
                                    .toggleStyle(CheckboxToggleStyleDown())
                                    .foregroundColor(.blue)
                                }
                                
                                
                                
                            }
                            
                            
                            
                        
                        
                        
                        
                    }
                    
                }
                .edgesIgnoringSafeArea(.all)
                
                
                
                
            }
        }.edgesIgnoringSafeArea(.all)
        
        
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
