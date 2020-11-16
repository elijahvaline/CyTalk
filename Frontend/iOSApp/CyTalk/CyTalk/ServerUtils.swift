//
//  ServerUtils.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/20/20.
//

import Foundation
import SwiftUI
//This one works but we need a new one
//struct DataSet: Decodable {
//    let fish: [SinglePost]
//}
//
//struct SinglePost: Decodable{
//    let id: Int
//    let date: Double
//    let at: String
//    let name: String
//    let content: String
//}


extension Data {
    mutating func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}

/// Post object for JSON
struct SinglePost: Decodable {
    let pId:Int
    let date:Double
    let userId:Int
    let userName:String
    let content:String
    let name:String
    let negVoteCount:Int
    
    let posVoteCount:Int
}

struct SingleChat: Decodable {
    let groupName:String
    let groupId:Int
    let users:[newUser]
}

/// User object for JSON
struct newUser: Decodable{
    
    let id:Int
    let fname:String
    let lname:String
    let password:String
    let email:String
    let type:Int
    let background:SinglePost?
    let profile:SinglePost?
    let bio:String
    let cookie:String?
    let uname:String
    
}

/// Comment Object for JSON
struct SingleComment: Decodable{
    
    let pId:Int
    let date:Double
    let content:String
    let name:String
    let userName:String
    let negVoteCount:Int
    let posVoteCount:Int
    let commentId:Int
    
}

/// Controller class with static functions for bring information from the model to the views.
class ServerUtils {
    
    //pi
//        static let serverUrl = "http://192.168.86.24:8081";
    //mac
//    static let serverUrl = "http://192.168.86.45:8081";
    
    static let serverUrl = "https://ba7c40c2-ac2f-46ac-9026-85e9696af0df.mock.pstmn.io/";
    static let serverUrl2 = "http://coms-309-sb-07.cs.iastate.edu:8080/"
    static let serverUrl3 = "http://coms-309-sb-07.cs.iastate.edu:8080/posts"
    static let serverUrl4 = "http://coms-309-sb-07.cs.iastate.edu:8080/post"
    
    /// Gets all the posts in the db
    /// - Parameter returnWith: Asychronous Callback
    /// - Returns: The array of post objects and success boolean
    static func getPost(returnWith: @escaping ([SinglePost]?, Bool)->()) {
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let uString = serverUrl
        
        if let url = URL(string: serverUrl3) {
            let task = session.dataTask(with: url, completionHandler: { data1, response, error in
                if (error != nil) {
                    returnWith(nil, false)
                    return
                }
                
                if let dataString = String(data: data1!, encoding: .utf8) {
                    print(dataString)
                    
                    do {
                        
                        let postSet = try decoder.decode([SinglePost].self, from: Data(dataString.utf8))
                        returnWith(postSet, true)
                        
                    }
                        
                    catch let jsonError {
                        print("Error Serializing JSON", jsonError)
                        returnWith(nil, false)
                    }
                } else {
                  returnWith(nil, false)
                }
                
            })
            
            task.resume()
            
        }
    }
    
    static func getChats(userName:String, returnWith: @escaping ([SingleChat]?, Bool)->()) {
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let uString = serverUrl
        
        if let url = URL(string: serverUrl2 + "/user/" + userName + "/group") {
            let task = session.dataTask(with: url, completionHandler: { data1, response, error in
                if (error != nil) {
                    returnWith(nil, false)
                    return
                }
                
                if let dataString = String(data: data1!, encoding: .utf8) {
                    print(dataString)
                    
                    do {
                        
                        let chatSet = try decoder.decode([SingleChat].self, from: Data(dataString.utf8))
                        returnWith(chatSet, true)
                        
                    }
                        
                    catch let jsonError {
                        print("Error Serializing JSON", jsonError)
                        returnWith(nil, false)
                    }
                } else {
                  returnWith(nil, false)
                }
                
            })
            
            task.resume()
            
        }
    }
    
    /// Get all the comments for a specific post
    /// - Parameters:
    ///   - pId: Id of post for desired comments
    ///   - returnWith: Asynchronous Callback
    /// - Returns: The array of comment objects and boolean indicating success
    static func getComments(pId:Int ,returnWith: @escaping ([SingleComment]?, Bool)->()) {
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let uString = serverUrl
        
        if let url = URL(string: serverUrl2 + "Comments/" + String(pId)) {
            let task = session.dataTask(with: url, completionHandler: { data1, response, error in
                if (error != nil) {
                    returnWith(nil, false)
                    return
                }
                
                if let dataString = String(data: data1!, encoding: .utf8) {
                    print(dataString)
                    
                    do {
                        
                        let commentSet = try decoder.decode([SingleComment].self, from: Data(dataString.utf8))
                        returnWith(commentSet, true)
                        
                    }
                        
                    catch let jsonError {
                        print("Error Serializing JSON", jsonError)
                        returnWith(nil, false)
                    }
                } else {
                  returnWith(nil, false)
                }
                
            })
            
            task.resume()
            
        }
    }
    
    
    /// Post request for logging in
    /// - Parameter returnWith: Asynchronous Callback
    /// - Returns: The new user object and a boolean indication request success.
    static func login(username:String, password:String, returnWith: @escaping (newUser?, Bool, Int)->()) {
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let uString = serverUrl
        
        let json: [String: Any] = ["password": password,
                                   "uname": username]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let url = URL(string: serverUrl2 + "login")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData

            let task = session.dataTask(with: request, completionHandler: { data1, response, error in
                if (error != nil) {
                    print(error)
                    returnWith(nil, false, 0)
                    
                    return
                }
                print("start")
                print(response)
                print("end")
                
               
                if let dataString = String(data: data1!, encoding: .utf8) {
                    print(dataString)
                    
                    do {
                        
                        if let httpResponse = response as? HTTPURLResponse {
                            
                            var status = httpResponse.statusCode
                            
                            if (status == 200){
                                let theUser = try decoder.decode(newUser.self, from: Data(dataString.utf8))
                                returnWith(theUser, true, status)
                            }
                            else if (status == 403 || status == 500){
                                returnWith(nil, true, status)
                            }
                        }
                    }
                        
                    catch let jsonError {
                        print("Error Serializing JSON", jsonError)
                        returnWith(nil, false, 0)
                    }
                } else {
                  returnWith(nil, false, 0)
                }
                
            })
            
            task.resume()
            
        
    }
    
    /// Get all the posts from a specific user
    /// - Parameters:
    ///   - username: Username of desired posts
    ///   - returnWith: Asynchronous callback
    /// - Returns: The array of post objects and boolean for success.
    static func getPostFromUser(username:String, returnWith: @escaping ([SinglePost]?, Bool)->()) {
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let uString = serverUrl3
        
        if let url = URL(string: serverUrl3 + "/" + username) {
            let task = session.dataTask(with: url, completionHandler: { data1, response, error in
                if (error != nil) {
                    returnWith(nil, false)
                    return
                }
                
                if let dataString = String(data: data1!, encoding: .utf8) {
                    print(dataString)
                    
                    do {
                        
                        let postSet = try decoder.decode([SinglePost].self, from: Data(dataString.utf8))
                        returnWith(postSet, true)
                        
                    }
                        
                    catch let jsonError {
                        print("Error Serializing JSON", jsonError)
                        returnWith(nil, false)
                    }
                } else {
                  returnWith(nil, false)
                }
                
            })
            
            task.resume()
            
        }
    }
    
    static func deletePost(postId:Int, returnWith: @escaping (Int)->() ){
        
        // create post request
        let url = URL(string: serverUrl2 + "postdelete/" + String(postId))!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
  
            if (error != nil) {
                print(error)
                returnWith(0)
                return
            }
            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
                return
            }
            print("start")
            if let httpResponse = response as? HTTPURLResponse {
                print("response \(httpResponse.statusCode)")
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
    //                print(responseJSON)
                }
                print("Youre here")
                returnWith(httpResponse.statusCode)
            }
        }
        task.resume()
    }
    
    static func deleteComment(commentId:Int, returnWith: @escaping (Int)->() ){
        
        // create post request
        let url = URL(string: serverUrl2 + "Commentdelete/" + String(commentId))!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
  
            if (error != nil) {
                print(error)
                returnWith(0)
                return
            }
            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
                return
            }
            print("start")
            if let httpResponse = response as? HTTPURLResponse {
                print("response \(httpResponse.statusCode)")
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
    //                print(responseJSON)
                }
                print("Youre here")
                returnWith(httpResponse.statusCode)
            }
        }
        task.resume()
    }
    
    
    /// Adds a user to the db
    /// - Parameters:
    ///   - userName: The username
    ///   - password: The password
    ///   - firstName: First name
    ///   - lastName:Last Name
    ///   - email: Email of new user
    ///   - returnWith: Asynchronous callback
    /// - Returns: Boolean for success of request.
    static func addUser(userName:String, password:String, firstName:String, lastName:String, email:String, returnWith: @escaping (Bool, Int)->() ){
        
        let json: [String: Any] = ["fname": firstName,
                                   "lname": lastName,
                                   "password": password,
                                   "email": email,
                                   "type": 0,
                                   "uname": userName,
                                   "bio" : ""
                                    ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        print(String(data: jsonData!, encoding: .utf8))
        
        // create post request
        let url = URL(string: serverUrl2 + "user")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
  
            if (error != nil) {
                print(error)
                returnWith(false, 0)
                return
            }
            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
                return
            }
            print("start")
            if let httpResponse = response as? HTTPURLResponse {
                print("response \(httpResponse.statusCode)")
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
    //                print(responseJSON)
                }
                print("Youre here")
                returnWith(true, httpResponse.statusCode)
               
            }
            
           
        }
        
        task.resume()
    }
    
    
    /// Post request to add a post to the db
    /// - Parameters:
    ///   - name: Name of the poster
    ///   - username: Username of the poster
    ///   - content: Content of the post
    ///   - returnWith: Asynchonous callback
    /// - Returns: Boolean if the post request succeeded.
    static func addPost(name:String, username:String, content:String, returnWith: @escaping (Bool)->() ){
        // prepare json data
        let today = Date()
        let timeDouble = today.timeIntervalSince1970
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let todaysDate:String = formatter.string(from: today)
        
        let json: [String: Any] = ["date": timeDouble,
                                   "userId": 5,
                                   "userName": username,
                                   "content" : content,
                                   "name": name,
                                   "postId": 10,
                                   "posVoteCount": 0,
                                   "negVoteVount": 0]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        print(String(data: jsonData!, encoding: .utf8))
        
        // create post request
        let url = URL(string: serverUrl4)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if (error != nil) {
                returnWith(false)
                return
            }
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            
            returnWith(true)
        }
        
        task.resume()
    }
    
    /// Static funtion to add a comment to the db
    /// - Parameters:
    ///   - name: Name of commenter
    ///   - username: Username of commenter
    ///   - content: Content of the comment
    ///   - postId: Id of post comment is relating to
    ///   - returnWith: The asynchronous callback
    /// - Returns: Boolean for the success/failure of the request.
    static func addComment(name:String, username:String, content:String, postId:Int, returnWith: @escaping (Bool)->() ){
        // prepare json data
        let today = Date()
        let timeDouble = today.timeIntervalSince1970
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let todaysDate:String = formatter.string(from: today)
        
        let json: [String: Any] = ["pId": postId,
                                   "date": timeDouble,
                                   "content": content,
                                   "name" : name,
                                   "userName": username,
                                   "posVoteCount": 0,
                                   "negVoteVount": 0]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        print(String(data: jsonData!, encoding: .utf8))
        
        // create post request
        let url = URL(string: serverUrl2 + "Comment")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if (error != nil) {
                returnWith(false)
                return
            }
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
            
            returnWith(true)
        }
        
        task.resume()
    }
    
    static func addPm(username1:String, username2:String, returnWith: @escaping (Int)->() ){
        // prepare json data
        let today = Date()
        let timeDouble = today.timeIntervalSince1970
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let todaysDate:String = formatter.string(from: today)
        
        let json: [String: Any] = ["uname": username2]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        print(String(data: jsonData!, encoding: .utf8))
        
        // create post request
        let url = URL(string: serverUrl2 + "user/" + username1 + "/private")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if (error != nil) {
                print(error)
                returnWith(0)
                
                return
            }

            if let dataString = String(data: data!, encoding: .utf8) {
                print(dataString)
                
                do {
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        
                        var status = httpResponse.statusCode
                        
                        if (status == 200){
                            
                            returnWith(status)
                        }
                        else {
                            returnWith(status)
                        }
                    }
                }
                    
                catch let jsonError {
                    print("Error Serializing JSON", jsonError)
                    returnWith(0)
                }
            } else {
              returnWith(0)
            }
            
        }
        
        task.resume()
    }
    ///Static function to change the type of the user
    static func changeUserType(user:String, type:Int, returnWith: @escaping (Int)->() ){
        
        let json: [String: Any] = ["type": type]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: serverUrl2 + "user/" + user + "/type")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if (error != nil) {
                print(error)
                returnWith(0)
                return
            }

            if let dataString = String(data: data!, encoding: .utf8) {
                print(dataString)
                
                do {
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        var status = httpResponse.statusCode
                        if (status == 200){
                            
                            returnWith(status)
                        }
                        else {
                            returnWith(status)
                        }
                    }
                }
                    
                catch let jsonError {
                    print("Error Serializing JSON", jsonError)
                    returnWith(0)
                }
            } else {
              returnWith(0)
            }
        }
        task.resume()
    }
    
    static func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
      var data = Data()

      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
      data.append(fileData)
      data.appendString("\r\n")

      return data as Data
    }
    
    
    
    static func addImage(returnWith: @escaping (Int)->() ){
        

        // create post request
        let url = URL(string: serverUrl2 + "user/eli/profile" )!
        let image = UIImage(named: "cover")
        var request = URLRequest(url: url)
        
        // insert json data to the request
        let boundary = "Boundary-\(UUID().uuidString)"
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = image!.jpegData(compressionQuality: 0.25)
        
    
        var httpBody = Data()

        httpBody.append(convertFileData(fieldName: "file",
                                        fileName: "imagename.jpg",
                                        mimeType: "image/jpg",
                                        fileData: imageData!,
                                        using: boundary))

        httpBody.appendString("--\(boundary)--")

        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("error statrts here///////////////////////////////////////////////////")
            if (error != nil) {
                print(error)
                returnWith(0)
                return
            }
            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                var status = httpResponse.statusCode
                if (status == 200){
                    
                    returnWith(status)
                }
                else {
                    returnWith(status)
                }
            print("Youre here")
            returnWith(0)
        }
        }
        
        task.resume()
    }

    
    static func profile(returnWith: @escaping (UIImage, Int)->()) {
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let uString = serverUrl
       
        
        let url = URL(string: serverUrl2 + "user/eli/profile")!
        
        var request = URLRequest(url: url)
        let boundary = "Boundary-\(UUID().uuidString)"
        
        request.httpMethod = "GET"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request

            let task = session.dataTask(with: request, completionHandler: { data1, response, error in
                if (error != nil) {
                    print(error)
                    return
                }
                print("start")
                print(response)
                print("end")
                
               
                if let image = UIImage(data: data1!) {
                    
                    do {
                        
                        if let httpResponse = response as? HTTPURLResponse {
                            
                            var status = httpResponse.statusCode
                            
                            if (status == 200){
                                
                                returnWith(image, status)
                            }
                           
                            
                        }
                    }
                        
                    catch let jsonError {
                        
                        print("error bro")
                        
                    }
                } else {
                  return
                }
                
            })
            
            task.resume()
            
        
    }
    
}
