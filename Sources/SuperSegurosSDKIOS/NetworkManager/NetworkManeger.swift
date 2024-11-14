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
        let url = env == "development" ? url.development : url.prodruction
        
        AF.request(url).responseDecodable(of: PickersCatalog.self) { (response) in
            debugPrint(response)
            switch response.result {
                case .success(let value):
                    completion(true, "", value)
                case .failure(let error):
                    completion(false, error.localizedDescription, nil)
            }
        }
    }
    
}
