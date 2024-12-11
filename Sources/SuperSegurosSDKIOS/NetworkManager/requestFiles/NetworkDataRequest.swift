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
    
    
    static let environment = Environment.Development
  

    enum endPoints {
        static let vehicle = "vehicle"
        static let model = "carModel"
        static let brand = "carBrands"
        static let subBrand = "carSubBrands"
        static let version = "descriptions"
        static let basicQuotation = "getBasicQuotation"
        static let generalQuotation = "getGeneralQuotation"
    }
 
    class func getVehicle(completion:@escaping(Bool, String, [TipoVehiculo]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.vehicle
               
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

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
    
    
    class func getModel( vehicleType:Int,completion:@escaping(Bool, String, [Modelo]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.model
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

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
    
    
    class func getBrand(vehicleType:Int,model:Int, completion:@escaping(Bool, String, [Marcas]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.brand
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManeger.sharedInstance
        
        let params:[String: Any] = [
            "vehicleType": vehicleType,
            "model": model
        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> [Marcas]? in
                if let dataArray = data as? [[String: Any]] {
                    let marcas = Marcas.initWithArray(dataArray)
                    return marcas
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
    
    
    class func getSubBrand(vehicleType:Int,model:Int,brand:Int, completion:@escaping(Bool, String, [SubMarcas]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.subBrand
               
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManeger.sharedInstance
        
        let params:[String: Any] = [
            "vehicleType": vehicleType,
            "model": model,
            "brand": brand,
        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> [SubMarcas]? in
                if let dataArray = data as? [[String: Any]] {
                    let submarcas = SubMarcas.initWithArray(dataArray)
                    return submarcas
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
    
    class func getVersion(vehicleType:Int,model:Int,brand:Int,subBrand:Int, completion:@escaping(Bool, String, [Version]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.version
               
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManeger.sharedInstance
        
        let params:[String: Any] = [
            "vehicleType": vehicleType,
            "model": model,
            "brand": brand,
            "subBrand": subBrand
        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> [Version]? in
                if let dataArray = data as? [[String: Any]] {
                    let version = Version.initWithArray(dataArray)
                    return version
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
    
    
    class func getBasicQuotation(vehicleType:Int,model:Int,brand:Int,subBrand:Int,internalKey:String, completion:@escaping(Bool, String, [BasicQuotation]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.basicQuotation
               
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManeger.sharedInstance
        
        let params:[String: Any] = [
            "vehicleType": vehicleType,
            "model": model,
            "brand": brand,
            "subBrand": subBrand,
            "internalKey": internalKey
        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> [BasicQuotation]? in
                if let dataArray = data as? [[String: Any]] {
                    let bq = BasicQuotation.initWithArray(dataArray)
                    return bq
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
    
    
    class func getGeneralQuotation(vehicleType:Int,model:Int,brand:Int,subBrand:Int,internalKey:String,insurance:String, completion:@escaping(Bool, String, [Cotizacion]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.generalQuotation
               
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManeger.sharedInstance
        
        let params:[String: Any] = [
            "vehicleType": vehicleType,
            "model": model,
            "brand": brand,
            "subBrand": subBrand,
            "internalKey": internalKey,
            "insurance": insurance
        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> [Cotizacion]? in
                if let dataArray = data as? [[String: Any]] {
                    let bq = Cotizacion.initWithArray(dataArray)
                    return bq
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
