////
////  imagetest.swift
////  CyTalk
////
////  Created by Elijah Valine on 11/15/20.
////
//
//import SwiftUI
//
//
//
//
//
//struct imagetest: View {
//    
//    @State var image: Image? = nil
//    @State var showCaptureImageView: Bool = false
//    var body: some View {
//        ZStack {
//          VStack {
//            Button(action: {
//              self.showCaptureImageView.toggle()
//            }) {
//              Text("Choose photos")
//            }
//            image?.resizable()
//              .frame(width: 250, height: 200)
//              .clipShape(Circle())
//              .overlay(Circle().stroke(Color.white, lineWidth: 4))
//              .shadow(radius: 10)
//          }
//          if (showCaptureImageView) {
////            CaptureImageView(isShown: $showCaptureImageView)
//          }
//        }
//    }
//    
////    func reloadImage(){
////        ServerUtils.profile(returnWith: { Image, status  in
////            if status == 200{
////                let temp:UIImage = Image
////
////                print("Success")
////
////                DispatchQueue.main.asyncAfter(deadline: .now()) {
////                    systemUser.profile = temp
////                }
////            }
////            else{
////                print("fail you bitch")
////            }
////        })
////    }
//}
//
//
//struct imagetest_Previews: PreviewProvider {
//    static var previews: some View {
//        imagetest()
//    }
//}
//
//
