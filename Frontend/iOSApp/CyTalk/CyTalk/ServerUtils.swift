//
//  ServerUtils.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/20/20.
//

import Foundation
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

struct SinglePost: Decodable {
    
    let date:Double
    let userId:Int
    let userName:String
    let content:String
    let name:String
    let posVoteCount:Int
    let postId:Int
    let negVoteCount:Int
}

class ServerUtils {
    //pi
//        static let serverUrl = "http://192.168.86.24:8081";
    //mac
//    static let serverUrl = "http://192.168.86.45:8081";
    
    static let serverUrl = "https://ba7c40c2-ac2f-46ac-9026-85e9696af0df.mock.pstmn.io/";
    static let serverUrl2 = "https://coms-309-sb-07.cs.iastate.edu:8080/"
    static let serverUrl3 = "http://coms-309-sb-07.cs.iastate.edu:8080/posts"
    static let serverUrl4 = "http://coms-309-sb-07.cs.iastate.edu:8080/post"
    
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
    

    static func addUser(userName:String, password:String, returnWith: @escaping (Bool)->() ){
        
        let json: [String: Any] = ["fname": "Ted",
                                   "lname": "Danson",
                                   "password": "help",
                                   "email":"test@tester2.com",
                                   "type": "User",
                                   "uname": "testUser"
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
                returnWith(false)
                return
            }
            guard let data = data, error == nil else {
//                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
//                print(responseJSON)
            }
            print("Youre here")
            returnWith(true)
        }
        
        task.resume()
    }
    
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
}
