//
//  HomeView.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/20/20.
//


import SwiftUI

struct HomeView: View {
    @Environment(\.presentationMode) public var presentationMode: Binding<PresentationMode>
    @ObservedObject public var systemUser:User
    @State var exit = false;
   
    var body: some View {
        
        
        
        ZStack{
            ZStack{
                
    //            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                if UIScreen.main.bounds.height > 800{
                    
                    Home(systemUser: self.systemUser)
                }
                else{
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        Home(systemUser: self.systemUser)
                    }
                }
            }
            
            
            VStack{
                HStack{
                    Button(action: {
                               self.presentationMode.wrappedValue.dismiss()
                            }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color("Color2"))
                        .font(.system(size: 35))

                        .padding(.top)
                        .padding(.leading, 25)
                    }
                    Spacer()
                }.padding(.leading, 20)
                Spacer()
            }.padding(.top, 20)
            
        }
        
       
        .navigationBarHidden(true)
        .accessibility(identifier: "loginView")
    }
    
  
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var index = 0
    @ObservedObject public var systemUser:User
    
    
    var body : some View{
        
        VStack{
            
            Image("logo")
            .resizable()
            .frame(width: 200, height: 150)
//                .shadow(radius: 5)
            
            HStack{
                
                Button(action: {
                    
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        
                       self.index = 0
                    }
                    
                }) {
                    
                    Text("Existing")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }.background(self.index == 0 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
                Button(action: {
                    
                   withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                       
                      self.index = 1
                   }
                    
                }) {
                    
                    Text("New")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical, 10)
                        .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                    
                }.background(self.index == 1 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
            }.background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top, 25)
            .shadow(radius: 5)
            
            if self.index == 0{
                
                Login(systemUser: self.systemUser)
            }
            else{
                
                SignUp(systemUser: self.systemUser)
            }
            
            if self.index == 0{

            }
            
            
        }
        .padding()
    }
}

struct Login : View {
    
    @State var user = ""
    @State var pass = ""
    @ObservedObject public var systemUser:User
    @Environment(\.presentationMode) public var presentationMode: Binding<PresentationMode>
    @State var shown = false
    var message = "Uh Oh! Wrong username or password"
    
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
    fileprivate func loginUser() {
        ServerUtils.login(username:user, password:pass, returnWith: { response, success, status  in
            
            if (success){
                if (status == 200){
                    let temp:newUser = response!
                    
                    print("Success")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        systemUser.username = temp.uname
                        systemUser.name = temp.fname + " " + temp.lname
                        systemUser.loggedIn = true
                        systemUser.type = temp.type
                        reloadImage()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                else{
                    shown = true
                }
                
                
            }
            if (!success){
                print("fail")
            }
            
        })
    }
    
    var body : some View{
        
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.black)
                    
                    TextField("Username", text: self.$user)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$pass)
                    
                    
                    
                }.padding(.vertical, 20)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            .shadow(radius: 5)
            
            
            Button(action: {
                
                loginUser()
                
            }) {
                
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                
            }.background(Color("Color2")

            )
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            .shadow(radius: 5)
            
            if $shown.wrappedValue {
                HStack{
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor((Color("Color2")))
                        .font(.system(size: 30))
                    
                    Text(self.message)
                }
                .padding(.top, 10)
                .padding(.bottom, 20.0)
                
            }
        }
    }
}

struct SignUp : View {
    

    @ObservedObject public var systemUser:User
    
    @State var username = ""
    @State var pass = ""
    @State var email = ""
    @State var fName = ""
    @State var lName = ""
    @Environment(\.presentationMode) public var presentationMode: Binding<PresentationMode>
    @State var exit = false
    @State var displayMessage = false
    var message = "Looks like that username is taken!"
    //why doesnt this work
    
    
    fileprivate func addNewUser() {
        ServerUtils.addUser(userName: username, password: pass, firstName: fName, lastName: lName, email: "noemail", returnWith: {success, response in
            
            if (!success ){
                
                print("fail")
                return
            }
            else{
                print("success")
                if (response == 200){
                    
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        systemUser.username = self.username
                        systemUser.name = self.fName + " " + self.lName
                        systemUser.loggedIn = true
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                else if (response == 500){
                    displayMessage = true
                }
            }
        })
    }
    
    var body : some View{
        
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(.black)
                    
                    TextField("Username", text: self.$username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$pass)
                    
                    Button(action: {
                        
                    }) {
                    }
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                    
                    TextField("First Name", text: self.$fName)
                        .autocapitalization(.none)
                     
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                    
                    TextField("Last Name", text: self.$lName)
                        .autocapitalization(.none)
                     
                    
                }.padding(.vertical, 20)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            .shadow(radius: 5)
            
          
            Button(action: {
                addNewUser()
                
                
                
            }) {
                
                Text("SIGNUP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                
            }.background(
            
                LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(8)
            .offset(y: -40)
            .padding(.bottom, -40)
            .shadow(radius: 5)
            
            if $displayMessage.wrappedValue {
                HStack{
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor((Color("Color2")))
                        .font(.system(size: 30))
                    
                    Text(self.message)
                }
                .padding(.top, 10)
                .padding(.bottom, 20.0)
                
            }
            
            
        }
    }
}


