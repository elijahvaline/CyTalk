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
            
            
            VStack{
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
           
            VStack{
                Text(name).font(.system(size: 40))
                    .fontWeight(.light)
                    .foregroundColor(.black)
                Text(handle)
                        .fontWeight(.light)
                    .foregroundColor(Color(UIColor.systemGray))
                Divider()
            }
            
                
        }
        .navigationBarHidden(true)
    }
}
