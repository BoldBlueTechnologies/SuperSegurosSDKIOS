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
        static let development = "https://devapiensurance.super.mx/api/"
        static let prodruction = "https://apihealth.midoconline.com/api/"
    }
    
    enum endPoints {
        static let vehicle = "vehicle"
        static let model = "carModel"
    }
 
    class func getVehicle(env: String,completion:@escaping(Bool, String, [TipoVehiculo]?)->()) {
        
        let queryURL = env == "development" ? url.development + endPoints.vehicle : url.prodruction + endPoints.vehicle
               
        let appKey = "jts1LXZ681Q7jKz7hVPwDmjkp1B9KrHNd"
        let headers: HTTPHeaders = ["App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManeger.sharedInstance
        
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .get,
            headers: headers,
            parseData: { data -> [TipoVehiculo]? in
                if let dataArray = data as? [[String: Any]] {
                    let tiposVehiculo = TipoVehiculo.initWithArray(dataArray)
                    return tiposVehiculo
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
    
    
    class func getModel(env: String, vehicleType:Int,completion:@escaping(Bool, String, [Modelo]?)->()) {
        
        let queryURL = env == "development" ? url.development + endPoints.model : url.prodruction + endPoints.model
               
        let appKey = "jts1LXZ681Q7jKz7hVPwDmjkp1B9KrHNd"
        let headers: HTTPHeaders = ["App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManeger.sharedInstance
        
        let params:[String: Any] = [
            "vehicleType": vehicleType
        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> [Modelo]? in
                if let dataArray = data as? [[String: Any]] {
                    let modelo = Modelo.initWithArray(dataArray)
                    return modelo
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
