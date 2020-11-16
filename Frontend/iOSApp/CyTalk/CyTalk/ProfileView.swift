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
    @State var posts: [Post] = [Post(content: "stirng", date: "string", name: "string", at: "Strng", initialized: false, pId: 1, prof: nil, isnil: true)]
    @ObservedObject public var systemUser:User
    @State var isUser:Bool
    @State var isMod:Bool
    @State var pic:UIImage
    @State var showCaptureImageView: Bool = false
    @State var whichOne:Bool = true
    @State var prUser = User()
    @State var coverPhoto = UIImage(named: "cover")
    private func makeAdmin(){
        ServerUtils.changeUserType(user: handle, type: 1, returnWith: { response in

        })
        
    }
    var body: some View {

        ZStack{
            
            
            VStack{
//                if !isUser{
                Image(uiImage: coverPhoto!)
                        .resizable()
                        .frame(width: 414, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .scaledToFit()
                        .shadow(radius: 5)
//                }
//                else{
//                    Image(uiImage: systemUser.background!)
//                        .resizable()
//                        .frame(width: 414, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//                        .scaledToFit()
//                        .shadow(radius: 5)
//                }
               
                Spacer()
                
                
            }
            
            
            VStack(spacing: 0){
                ZStack{
                    Image(systemName: "circle.fill")
                        .font(.system(size: 220))
                        .shadow(radius: 5)
                        .foregroundColor(.white)
                   
                    if isUser{
                        Image(uiImage: systemUser.profile!)
                            .resizable()
                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                    
                    }
                    else{
                        Image(uiImage: pic)
                            .resizable()
                        .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .clipShape(Circle())
                    }
                       
                    
                    
                    
                }.padding(.top, 150)
                
                Spacer()
                
               
                    Text(name).font(.system(size: 40))
                        .fontWeight(.light)
                        .foregroundColor(.black)
                    Text(handle)
                            .fontWeight(.light)
                        .foregroundColor(Color(UIColor.systemGray))
                        .padding(.bottom, 7)
                    Divider()
                    
                    ScrollView{
                        
                        VStack(spacing: 0) {
                            if posts.count != 0{
                            if posts[0].isInitialized! {
                            ForEach(posts, id: \.self) { post in
    //
    //                            NavigationLink(destination: PostCommentView(content: post.content!, date: post.date!, name: po st.name!, handle: post.at!)){
    //
    //                            }
                                
                                
                                    
                                        HStack{
                                            if isUser{
                                                Image(uiImage: systemUser.profile!)
                                                    .resizable()
                                                .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .clipShape(Circle())
                                            
                                            }
                                            else{
                                                Image(uiImage: pic)
                                                    .resizable()
                                                .frame(width: 15, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                                .clipShape(Circle())
                                            }
                                            Text(post.name!)
                                                .foregroundColor(.black)
                                                
                                            Text(post.at!)
                                                .foregroundColor(.gray)
                                                
                                            Text(post.date!)
                                                .foregroundColor(.gray)
                                             
                                                
                                            Spacer()
                                            
                                        }
                                    
                                    .accessibility(identifier: post.at!)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 1)
                                    .padding(.top, 5)
                                    .padding(.horizontal, 15)
                                
                                NavigationLink(destination: PostCommentView(content: post.content!, date: post.date!, name: post.name!, handle: post.at!, pId: post.pId!, systemUser: self.systemUser, pic: self.pic)) {
                                    Text(post.content!)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 5)
                                }
                                .padding(.horizontal, 15)
                                .accessibility(identifier: post.name!)
    //                            .hidden(!post.isInitialized)
                                
                                
                                
                                Divider()
                                   
                                
                            }
                            
                        }
                            }
                            
                        }
                        
                    }
            }
            
            VStack{
                HStack{
                    
                    Button(action: {
                               self.presentationMode.wrappedValue.dismiss()
                            }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .font(.system(size: 30))

//                        .padding(.top)
                    }
                    .padding(.leading, 35)
                    
                    Spacer()
                    
//                    if $isMod.wrappedValue {
                        
                        Menu{
                            if $isMod.wrappedValue && !$isUser.wrappedValue{
                                Button("Make Mod", action: makeAdmin)
                            }
                            
                            if $isUser.wrappedValue {
                                Button("Log Out", action: logOut)
                                Button("Add Profile Picture", action:{ self.showCaptureImageView.toggle(); self.whichOne = true})
                                Button("Add Cover Picture", action:{ self.showCaptureImageView.toggle(); self.whichOne = false})
                                
                            }
                        } label: {
                            Label("", systemImage: "chevron.down")
                                .foregroundColor(.white)
                                .font(.system(size: 30))
                                .frame(height: isModOrUser() ? 100 : 0)
                        }
                        
                        .padding(.trailing, 30)
              
                }
    
                Spacer()
            }
     
            if (showCaptureImageView){
                CaptureImageView(isShown: $showCaptureImageView, isProfile: $whichOne, username: handle, systemUser: systemUser)
               
            }
        }
        
        .onAppear(){
            
                getCover()
            
            updatePosts()
        
        }
        .navigationBarHidden(true)
    }
  
    func isModOrUser() -> Bool {
        return isMod || thisUser()
    }
    func logOut(){
        systemUser.logOut()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func getCover(){
        ServerUtils.profile(username: handle, type: "background", returnWith: { image, status in
            
            if (status == 200){
                
                    coverPhoto = image
               
                    
                }
                
            
        })
    }
    
    func thisUser() -> Bool {
        if (systemUser.username == self.handle){
            return true
        }
        else{
            return false
        }
    }
    
    func updatePosts() {
        ServerUtils.getPostFromUser(username: handle, returnWith:  { response, success in
            if (!success) {
                
                // Show error UI here
                print("OH NO IT FAILED")
                return;
            }
            
            
            let postSet:[SinglePost] = response!
                
            
    
            var curPost:SinglePost
            
            // Cant modify state variable directly multiple times without swiftui class
            var tempPost:[Post] = []
            for fish in postSet {
                
                curPost = fish
                
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                let myNSDate = Date(timeIntervalSince1970: curPost.date)
                let todaysDate:String = formatter.string(from: myNSDate)
                let postName:String
                let userName:String
                
                if (curPost.name == nil){
                    postName = "Anon"
                }
                else{
                    postName = curPost.name
                }
                
                if (curPost.userName == nil){
                    userName = "Anon"
                }
                else{
                    userName = curPost.userName
                }
                
                
                tempPost.append(Post(content: curPost.content, date: todaysDate, name: postName, at: userName, initialized:true, pId: curPost.pId, prof:nil, isnil: true))

            }
            tempPost.reverse()
            // Copy array over
            self.posts = tempPost
            
        })
    }
}

struct CaptureImageView {
  
  /// MARK: - Properties
  @Binding var isShown: Bool
  @Binding var isProfile: Bool
    @State var username:String
    @ObservedObject var systemUser:User
    
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(isShown: $isShown, profile: $isProfile, thisusername: username, sysUser: systemUser)
  }
}

extension CaptureImageView: UIViewControllerRepresentable {
  func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    /// Default is images gallery. Un-comment the next line of code if you would like to test camera
//    picker.sourceType = .camera
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController,
                              context: UIViewControllerRepresentableContext<CaptureImageView>) {
    
  }
}


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isCoordinatorShown: Bool
    @Binding var isProfile: Bool
    @ObservedObject var systemUser:User
    var user:String
    var typer = "profile"
    
    init(isShown: Binding<Bool>, profile: Binding<Bool>, thisusername:String, sysUser:User) {
        _isCoordinatorShown = isShown
        _isProfile = profile
        user = thisusername
        systemUser = sysUser
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if (!isProfile){
            typer = "background"
        }
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        ServerUtils.addImage(username: user, type: typer, userImage: unwrapImage, returnWith: { status in
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                
                self.reloadImage(type:self.typer)
                self.isCoordinatorShown = false
                
            }
            
        })
        
        
    }
    
    func reloadImage(type:String){
        ServerUtils.profile(username: user, type: type, returnWith: { Image, status  in
            if status == 200{
                let temp:UIImage = Image
                
                print("Success")
                
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    if (type == "profile"){
                        self.systemUser.profile = temp
                    }
                    else{
                        self.systemUser.background = temp
                    }
                   
                }
            }
            else{
                print("fail")
            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
}
