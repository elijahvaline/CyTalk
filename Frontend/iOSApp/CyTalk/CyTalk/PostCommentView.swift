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
    
    var body: some View {
        
        VStack{
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
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Text(handle)
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }.frame(alignment: .leading)
                
               
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.bottom, 5)
            Text(content)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.horizontal)
            
            HStack{
                Text(date)
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                    .font(.system(size:20))
                Spacer()
            }
            
            
            Divider().padding(.horizontal)
      
            ZStack{
                Rectangle()
                    .frame(width: 375, height: 40)
                    .cornerRadius(25)
                    .foregroundColor(Color(UIColor.systemGray5))
//                    .background(Color(UIColor.systemGray5))

                    
                TextField("What would you like to say?", text: $test)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(UIColor.systemGray))
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(20)
                    .frame(width: 375, height: 50)
                    .font(.system(size:20))
                    
                    .padding(.horizontal, 20)
                
            
                
            }
            
            Divider().padding(.horizontal)
                
            
            
            Spacer()
            
            
                .navigationBarHidden(true)
            
        }
        
        
        
    }
}
//
//struct PostCommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostCommentView()
//    }
//}
