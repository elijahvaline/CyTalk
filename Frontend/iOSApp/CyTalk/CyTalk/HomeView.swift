//
//  HomeView.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/20/20.
//

import SwiftUI

struct LoginView: View {
      var body: some View {
          
          ZStack{
              
              LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
              
              if UIScreen.main.bounds.height > 800{
                  
                  HomeView()
              }
              else{
                  
                  ScrollView(.vertical, showsIndicators: false) {
                      
                      HomeView()
                  }
              }
          }
      }
  }

struct HomeView : View {
    
    @State var index = 0
    
    var body : some View{
        
        
        
        VStack{
            
            Image("logo")
            .resizable()
            .frame(width: 200, height: 150)
            
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
            
            if self.index == 0{
                
                Login()
            }
            else{
                
                SignUp()
            }
            
            if self.index == 0{

            }
            
            
           
            
        }
        .padding()
    }
}

struct Login : View {
    
    @State var mail = ""
    @State var pass = ""
    
    var body : some View{
        
        NavigationView{
            VStack{
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "person")
                            .foregroundColor(.black)
                        
                        TextField("Enter Email Address", text: self.$mail)
                        
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
                
                NavigationLink(destination: PostsView()) {
                    Text("LOGIN")
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
                .shadow(radius: 15)
            }
        }
        
     
    }
}

struct SignUp : View {
    
    @State var mail = ""
    @State var pass = ""
    @State var repass = ""
    
    var body : some View{
        
        VStack{
            
            VStack{
                
                HStack(spacing: 15){
                    
                    Image(systemName: "person")
                        .foregroundColor(.black)
                    
                    TextField("Enter Username", text: self.$mail)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                    
                    SecureField("Password", text: self.$pass)
 
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15){
                    
                    Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                    
                    SecureField("Re-Enter", text: self.$repass)
                    

                    
                }.padding(.vertical, 20)
                
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            
            
            Button(action: {
                
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
            .shadow(radius: 15)
        }
    }
}


