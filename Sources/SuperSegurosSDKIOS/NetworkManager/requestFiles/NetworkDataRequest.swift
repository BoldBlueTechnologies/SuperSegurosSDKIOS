//
//  NetworkDataRequest.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 14/11/24.
//

import UIKit
import Foundation
import Alamofire

class NetworkDataRequest: NSObject {
    
    enum url {
        static let development = "https://devapihealth.midoconline.com/api/"
        static let prodruction = "https://apihealth.midoconline.com/api/"
    }
    
    enum endPoints {
        static let pickerList = "medical-records/pickers"
    }
 
    class func getPickersCatalog(env: String,completion:@escaping(Bool, String, PickersCatalog?)->()) {
        
        let queryURL = env == "development" ? url.development + endPoints.pickerList : url.prodruction + endPoints.pickerList
               
        let BearerToken = "911|iexTioguCzz5QXTG2TFDvU6k86r2Ncu2N7AjkzyS61ae9494"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(BearerToken)"]

        let sessionDelegate = NetworkManeger.sharedInstance
        
        sessionDelegate.performRequest(
            showResult:false,
            queryURL: queryURL,
            method: .get,
            headers: headers,
            parseData: { data -> PickersCatalog? in
                if let dataDict = data as? [String: Any] {
                    
                    let info = PickersCatalog.initWithDictionary(dataDict)
                    return info
                    
                }
                return nil
              
            },
            completion: { success, message, data in
                if success {
                    completion(true, message, data)
                } else {
                    completion(false, message, nil)
                }
            }
        )
        
  
    }
}
