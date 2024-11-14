//
//  NetworkManeger.swift
//  SuperSegurosSDKIOS
//
//  Created by Oscar Aguilar on 14/11/24.
//

import Foundation
import Alamofire


class NetworkManeger: NSObject{
    
    enum url {
        static let development = "https://devapihealth.midoconline.com/api/"
        static let prodruction = "https://apihealth.midoconline.com/api/"
    }
    
    enum endPoints {
        static let pickerList = "medical-records/pickers"
    }
 
    class func getPickersCatalog(env: String,completion:@escaping @Sendable(Bool, String, PickersCatalog?)->()) {
        let url = env == "development" ? url.development + endPoints.pickerList : url.prodruction + endPoints.pickerList
        
        let BearerToken = "911|iexTioguCzz5QXTG2TFDvU6k86r2Ncu2N7AjkzyS61ae9494"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(BearerToken)"]
        
        AF.request(url,method: .get, headers: headers).responseDecodable(of: PickersCatalog.self) { (response) in
            debugPrint(response)
            switch response.result {
                case .success(let value):
                    let dictionary = value as! [String: Any]
                    if let status = dictionary["status"] as? String {
                        let message = dictionary["message"] as! String
                        if status == "Success" {
                        
                            let dataDict =  dictionary["data"] as! [String : Any]
                            let info = PickersCatalog.initWithDictionary(dataDict)
                            completion(true, message, info)
                           
                        } else {
                            completion(false, "errorservice" + endPoints.pickerList, nil)
                        }
                    } else {
                        
                        completion(false, "errorservice" + endPoints.pickerList, nil)
                    }
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
            }
        }
    }
    
}
