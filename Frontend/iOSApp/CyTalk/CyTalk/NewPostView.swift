//
//  NewPostView.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/21/20.
//

import SwiftUI

struct NewPostView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var postContent:String = ""
    @State var message:String = ""
    @State var showPopUp:Bool = false
    var body: some View {
        VStack{
            HStack(spacing: 130){
                Button(action: {
                           self.presentationMode.wrappedValue.dismiss()
                        }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color("Color2"))
                    .font(.system(size: 30))
                }
                Image(systemName: "person.crop.circle")
                    .foregroundColor(Color("Color2"))
                    .font(.system(size: 50))
                
                Button(action: {
                    ServerUtils.addPost(name: "anon", username: "anon", content: postContent, returnWith: {success in
                        
                        if (!success ){
                            message = "Ope! Having trouble connecting"
                            showPopUp = true
                            print("fail")
                            return
                        }
                        else{
                            showPopUp = true
                            message = "Good to go"
                            print("success")
//                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                    })
                    
                    self.presentationMode.wrappedValue.dismiss()
                        }) {
                Image(systemName: "arrowshape.turn.up.right.fill")
                    .foregroundColor(Color("Color2"))
                    .font(.system(size: 30))
                }.accessibility(identifier: "post")
            }
            
            TextField("Whats up?", text: $postContent)
                .multilineTextAlignment(.center)
                .padding(.top, 5)
                .frame(width: 400)
                .accessibility(identifier: "worked")
                

            Spacer()
            if $showPopUp.wrappedValue {
                HStack{
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 30))

                    Text(self.message)
                }
                .padding(.top, 10)
                .padding(.bottom, 20.0)

            }
            
            Divider()
            HStack(spacing: 25){
                Image(systemName: "link")
                    .font(.system(size: 30))
                    .foregroundColor(Color("Color2"))
                    
                Image(systemName: "camera.fill")
                    .foregroundColor(Color("Color2"))
                    .font(.system(size: 30))
                Spacer()
            }.padding(.leading, 15)
            .frame(height: 50)
        
        }
        
        .navigationBarHidden(true)
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
