//
//  ServerUtils.swift
//  CyTalk
//
//  Created by Elijah Valine on 9/20/20.
//

import Foundation

struct DataSet: Decodable {
    let fish: [SinglePost]
}

struct SinglePost: Decodable{
    let id: Int
    let date: Double
    let at: String
    let name: String
    let content: String
}

class ServerUtils {
    //pi
//        static let serverUrl = "http://192.168.86.24:8081";
    //mac
//    static let serverUrl = "http://192.168.86.45:8081";
    
    static let serverUrl = "https://ba7c40c2-ac2f-46ac-9026-85e9696af0df.mock.pstmn.io/";

    
    static func getPost(returnWith: @escaping (DataSet?, Bool)->()) {
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        let uString = serverUrl
        
        if let url = URL(string: serverUrl + "/post/") {
            let task = session.dataTask(with: url, completionHandler: { data1, response, error in
                if (error != nil) {
                    returnWith(nil, false)
                    return
                }
                
                if let dataString = String(data: data1!, encoding: .utf8) {
                    print(dataString)
                    
                    do {
                        
                        let postSet = try decoder.decode(DataSet.self, from: Data(dataString.utf8))
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
    
    static func addPost(content:String, returnWith: @escaping (Bool)->() ){
        // prepare json data
        let today = Date()
        let timeDouble = today.timeIntervalSince1970
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let todaysDate:String = formatter.string(from: today)
        
        let json: [String: Any] = ["date": timeDouble,
                                   "content": content,
                                   "username": "bobyboy"]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        print(String(data: jsonData!, encoding: .utf8))
        
        // create post request
        let url = URL(string: serverUrl + "addPost/")!
        
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
}
