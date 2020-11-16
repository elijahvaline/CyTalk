//
//  imagetest.swift
//  CyTalk
//
//  Created by Elijah Valine on 11/15/20.
//

import SwiftUI

struct imagetest: View {
    @ObservedObject public var systemUser = User()
    var body: some View {
        if systemUser.profile == nil{
            Image(systemName: "person.crop.circle")
                .font(.system(size: 400))
                .foregroundColor(Color("Color2"))
        }
        else{
            Image(uiImage: systemUser.profile!)
                .resizable()
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipShape(Circle())
            
        }
  
       
    }
    
    func reloadImage(){
        ServerUtils.profile(returnWith: { Image, status  in
            if status == 200{
                let temp:UIImage = Image
                
                print("Success")
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    systemUser.profile = temp
                }
            }
            else{
                print("fail you bitch")
            }
        })
    }
}


struct imagetest_Previews: PreviewProvider {
    static var previews: some View {
        imagetest()
    }
}
