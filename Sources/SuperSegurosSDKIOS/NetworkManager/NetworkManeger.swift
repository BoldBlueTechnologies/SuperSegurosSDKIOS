//
//  NetworkManeger.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 14/11/24.
//

import UIKit
import Foundation
import Alamofire

struct GenericResponse<T> {
    let status: String
    let message: String
    let code: Int
    let data: T?
}

class NetworkManeger: NSObject, URLSessionDelegate, @unchecked Sendable {
    
    var session: URLSession!
    var afSession: Session!
    
    static let sharedInstance = NetworkManeger()

    private override init() {
        super.init()
        
        session = URLSession.init(configuration: .ephemeral, delegate: self, delegateQueue: nil)
        afSession = Session.init()
    }
    
    typealias DataParser<T> = (Any) -> T?
    
    func performRequest<T>(
        showResult: Bool = true,
        queryURL: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders? = nil,
        parseData: @escaping DataParser<T>,
        completion: @escaping (Bool, String, T?) -> ()
    ) {
        let sessionDelegate = NetworkManeger.sharedInstance
        
        print("-------------")
        print("queryURL: \(queryURL)")
        print("params: \(parameters ?? ["0": "not params"])")
        print("-------------")
        print("method: \(method.rawValue)")
        print("-------------")
        
        sessionDelegate.afSession.request(queryURL, method: method, parameters: parameters, headers: headers).responseJSON { response in
            let result = response.result
                     
                     print("=============")
                     print("queryURL: \(queryURL)")
                     print("headers: \(String(describing: headers))")
            if showResult {
                print(result)
            }
                     
            switch result {
            case .success(let value):
                guard let dictionary = value as? [String: Any],
                    let status = dictionary["status"] as? String, let message = dictionary["message"] as? String,
                    let code = dictionary["code"] as? Int else {
                        
                        completion(false, "Invalid server response", nil)
                        
                        return
                    }
                
                if status  == "Success" {
                    print("Success: ✅")
                    if let data = dictionary["data"] {
 
                        let parsed = parseData(data)
                        if let parsed = parsed {
                            completion(true, message, parsed)
                            print("Message: \(message)")
                        } else {
                            print("Error: parsing failed: \(queryURL)")
                            completion(true, message, nil)
                        }
                    } else {
                        completion(false, "No valid data", nil)
                    }
                } else {
                    
                    let statusCode = response.response?.statusCode
                    
                    if statusCode == 401 {
                        
                        if queryURL.contains("logout") {
                            
                            print("aqui se cerraba la session")
                            
                        } else {
                            
                            print("statusCode 401 \(queryURL)")
                            sessionDelegate.afSession.cancelAllRequests()
                        }
                        
                       return
                    } else {
                        if let data = dictionary["data"] {
     
                            let parsed = parseData(data)
                            if let parsed = parsed {
                                completion(false, message, parsed)
                                print("Message: \(message)")
                            } else {
                                print("Error: parsing failed: \(queryURL)")
                                completion(false, message, nil)
                            }
                        } else {
                            completion(false, "No valid data", nil)
                        }
                    }
                    print("Failed: ❌")
                  
                }
                print("Message: \(message)")
            case .failure(let error):
                print("Server error: \(error.localizedDescription)")
                completion(false, error.localizedDescription, nil)
            }
        }
    }
    
}
