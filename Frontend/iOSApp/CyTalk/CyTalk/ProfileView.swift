//
//  ProfileView.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/21/20.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack{
            VStack{
                Image("cover")
                    .resizable()
                    .frame(width: 414, height: 448, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .scaledToFit()
                    .shadow(radius: 5)
                Spacer()
                Text("All Profile information here")
                    .foregroundColor(.gray)
                
            }
            
            
            Image(systemName: "circle.fill")
                .font(.system(size: 220))
                .shadow(radius: 5)
                .foregroundColor(.white)
            
            Image(systemName: "person.crop.circle")
                .font(.system(size: 200))
                .foregroundColor(Color("Color2"))
            
            Button(action: {
                       self.presentationMode.wrappedValue.dismiss()
                    }) {
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .font(.system(size: 35))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
                .padding(.top)
                .padding(.leading, 25)
            }
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
