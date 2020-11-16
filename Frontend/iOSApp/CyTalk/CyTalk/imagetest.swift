////
////  imagetest.swift
////  CyTalk
////
////  Created by Elijah Valine on 11/15/20.
////
//
//import SwiftUI
//
//struct imagetest: View {
//    @ObservedObject public var systemUser = User()
////    @State var post = Post(content: "stirng", date: "string", name: "string", at: "Strng", initialized: false, pId:0)
//    var body: some View {
//        if post.photos?.profile == nil{
//            Image(systemName: "person.crop.circle")
//                .font(.system(size: 200))
//                .foregroundColor(Color("Color2"))
//        }
//        else{
//            Image(uiImage: (post.photos?.profile)!)
//                .resizable()
//                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                .clipShape(Circle())a
//            
//        }
//        
//            
//        
//        Button(action: {
//            reloadImage()
//        }) {
//            Image(systemName: "arrow.clockwise")
//                .foregroundColor(Color("Color2"))
//                .font(.system(size: 35))
//        }
//       
//    }
//    
//    func reloadImage(){
//        ServerUtils.profile(returnWith: { Image, status  in
//            if status == 200{
//                let temp:UIImage = Image
//                
//                print("Success")
//                
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    systemUser.profile = temp
//                }
//            }
//            else{
//                print("fail you bitch")
//            }
//        })
//    }
//}
//
//
//struct imagetest_Previews: PreviewProvider {
//    static var previews: some View {
//        imagetest()
//    }
//}
