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
        static let setDataCar = "dataCar"
        static let setDataDriver = "dataDriver"
        static let setDataAddress = "dataAddress"
        static let verifyEmail = "verifyEmail"
        static let associateUser = "associateUser"
        static let registerUser = "registerUser"
        static let addressValidation = "addressValidation"
        static let catalogs = "catalogs"
        static let saveQuotation = "saveQuotation"
        static let saveCoverages = "saveCoverages"
        static let payQuotation = "payQuotation"
        
    }
    
    class func saveCoverages( carQuoteId:Int,insurer:String,plan:String,coverage:String,completion:@escaping(Bool, String, Int?)->()) {
        
        let queryURL = environment.baseURL + endPoints.saveCoverages
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        let params:[String: Any] = [
            "carQuoteId": carQuoteId
            ,"insurer": insurer
            ,"plan": plan
            ,"coverage": coverage
        

        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Int? in
                if let dataArray = data as? NSDictionary {
                    let bq = dataArray["coverageId"] as? Int
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
    
    
    class func saveQuotation( carType:String,year:String,brand:String,model:String,version:String,postalCode:String,completion:@escaping(Bool, String, Int?)->()) {
        
        let queryURL = environment.baseURL + endPoints.saveQuotation
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        let params:[String: Any] = [
            "carType": carType
            ,"year": year
            ,"brand": brand
            ,"model": model
            ,"version": version
            ,"postalCode": postalCode

        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Int? in
                if let dataArray = data as? NSDictionary {
                    let bq = dataArray["carQuoteId"] as? Int
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
    
    class func getAddress( postalCode:Int,completion:@escaping(Bool, String, Address?)->()) {
        
        let queryURL = environment.baseURL + endPoints.addressValidation
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        let params:[String: Any] = [
            "postalCode": postalCode
        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Address? in
                if let dataArray = data as? NSDictionary {
                    let modelo = Address.initWithDictionary(dataArray)
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
    
    class func getCatalogs(completion:@escaping(Bool, String, PersonalInfo?)->()) {
        
        let queryURL = environment.baseURL + endPoints.catalogs
               
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .get,
            headers: headers,
            parseData: { data -> PersonalInfo? in
                if let dataArray = data as? NSDictionary {
                    let model = PersonalInfo.initWithDictionary(dataArray)
                    return model
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
    
    
    class func getVehicle(completion:@escaping(Bool, String, [TipoVehiculo]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.vehicle
               
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
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

        let sessionDelegate = NetworkManager.sharedInstance
        
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

        let sessionDelegate = NetworkManager.sharedInstance
        
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

        let sessionDelegate = NetworkManager.sharedInstance
        
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

        let sessionDelegate = NetworkManager.sharedInstance
        
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
    
    
    class func getBasicQuotation(vehicleType:Int,model:Int,brand:Int,subBrand:Int,internalKey:String,zipCode:String, completion:@escaping(Bool, String, [BasicQuotation]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.basicQuotation
               
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        let params:[String: Any] = [
            "vehicleType": vehicleType,
            "model": model,
            "brand": brand,
            "subBrand": subBrand,
            "internalKey": internalKey,
            "zipCode": zipCode
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
    
    
    class func getGeneralQuotation(vehicleType:Int,model:Int,brand:Int,subBrand:Int,internalKey:String,insurance:String,zipCode:String, completion:@escaping(Bool, String, [Cotizacion]?)->()) {
        
        let queryURL = environment.baseURL + endPoints.generalQuotation
               
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        let params:[String: Any] = [
            "vehicleType": vehicleType,
            "model": model,
            "brand": brand,
            "subBrand": subBrand,
            "internalKey": internalKey,
            "insurance": insurance,
            "zipCode": zipCode
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
    
    
    class func setDataCar( licensePlate:String,vin:String,engineNumber:String,coverageId:Int,idCar:Int? = nil,completion:@escaping(Bool, String, Int?)->()) {
        
        let queryURL = environment.baseURL + endPoints.setDataCar
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        var params:[String: Any] = [
            "licensePlate": licensePlate,
            "VIN": vin,
            "engineNumber": engineNumber,
            "idCoverage": coverageId,
           
        ]
        
        if let idCar = idCar {
            params["idCar"] = idCar
        }
        
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Int? in
                if let dataArray = data as? NSDictionary {
                    let bq = dataArray["id_car"] as? Int
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
    
    class func setDataDriver( idCar:Int,name:String,paternalSurname:String,maternalSurname:String,bornDate:String, gender:String,maritalStatus:String,rfc:String,idDriver:Int? = nil, completion:@escaping(Bool, String, Int?)->()) {
        
        let queryURL = environment.baseURL + endPoints.setDataDriver
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        var params:[String: Any] = [
            "id_car": idCar,
            "name": name,
            "paternalSurname": paternalSurname,
            "maternalSurname": maternalSurname,
            "bornDate": bornDate,
            "gender": gender,
            "maritalStatus": maritalStatus,
            "rfc": rfc
        ]
        
        if let idDriver = idDriver {
            params["idDriver"] = idDriver
        }
        
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Int? in
                if let dataArray = data as? NSDictionary {
                    let bq = dataArray["id_driver"] as? Int
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
    
    class func setDataAddress( idDriver:Int,street:String,apartmentNumber:String,streetNumber:String,state:String,city:String,zipCode:String,neighborhood:String,idAddress:Int? = nil,completion:@escaping(Bool, String, Int?)->()) {
        
        let queryURL = environment.baseURL + endPoints.setDataAddress
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        var params:[String: Any] = [
            "id_driver": idDriver,
            "street": street,
            "apartmentNumber": apartmentNumber,
            "streetNumber": streetNumber,
            "state": state,
            "city": city,
            "ZIPCode": zipCode,
            "neighborhood": neighborhood

        ]
        if let idAddress = idAddress {
            params["idAddress"] = idAddress
        }
        
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Int? in
                if let dataArray = data as? NSDictionary {
                    let bq = dataArray["id_Address"] as? Int
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
    
    class func verifyEmail( email:String,completion:@escaping(Bool, String, Int?)->()) {
        
        let queryURL = environment.baseURL + endPoints.verifyEmail
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        let params:[String: Any] = [
            "email": email

        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Int? in
                if let dataArray = data as? NSDictionary {
                    let bq = dataArray["registrado"] as? Int
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
    
    class func associateUser( email:String,password:String,completion:@escaping(Bool, String, Int?)->()) {
        
        let queryURL = environment.baseURL + endPoints.associateUser
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        let params:[String: Any] = [
            "email": email,
            "password": password

        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Int? in
                if let dataArray = data as? NSDictionary {
                    let bq = dataArray["userId"] as? Int
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
    
    class func registerUser( uid:Int,name:String,paternalSurname:String,maternalSurname:String,email:String,password:String,prefijo:String,phoneNumber:String,latitud:String,longitud:String,comoConocio:String,origen:String,completion:@escaping(Bool, String, Int?)->()) {
        
        let queryURL = environment.baseURL + endPoints.registerUser
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        let params:[String: Any] = [
            "uid": uid,
            "name": name,
            "paternalSurname": paternalSurname,
            "maternalSurname": maternalSurname,
            "email": email,
            "password": password,
            "prefijo": prefijo,
            "phoneNumber": phoneNumber,
            "latitud": latitud,
            "longitud": longitud,
            "comoConocio": comoConocio,
            "origen": origen

        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Int? in
                if let dataArray = data as? NSDictionary {
                    let bq = dataArray["userId"] as? Int
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
    
    
    @MainActor class func payQuotation(startingAt:String,
                            holderName:String
                             ,cardNumber:String
                             ,year:String
                             ,month:String
                             ,cvv:String
                            
    ,completion:@escaping(Bool, String, Document?)->()) {
        
        let queryURL = environment.baseURL + endPoints.payQuotation
        
        let appKey = environment.appKey
        let headers: HTTPHeaders = ["X-App-Key": "\(appKey)"]

        let sessionDelegate = NetworkManager.sharedInstance
        
        let params:[String: Any] = [
            "quoteId": PayQuotationData.shared.quote?.numeroCotizacion ?? "",
            "startingAt": startingAt,
            "serial": PayQuotationData.shared.serial ?? "",
            "motorNumber": PayQuotationData.shared.motorNumber ?? "",
            "carPlateNumber": PayQuotationData.shared.carPlateNumber ?? "",
            "typeVehicleId": PayQuotationData.shared.typeVehicleId ?? 0,
            "name": PayQuotationData.shared.name ?? "",
            "paternalSurname": PayQuotationData.shared.paternalSurname ?? "",
            "maternalSurname": PayQuotationData.shared.maternalSurname ?? "",
            "gender": PayQuotationData.shared.gender ?? 0,
            "maritalStatus": PayQuotationData.shared.maritalStatus ?? 0
            ,"email": PayQuotationData.shared.email ?? ""
            ,"birthDate": PayQuotationData.shared.birthDate ?? ""
            ,"rfc": PayQuotationData.shared.rfc ?? ""
            ,"entity": PayQuotationData.shared.entity ?? ""
            ,"municipality": PayQuotationData.shared.municipality ?? ""
            ,"neighborhood": PayQuotationData.shared.neighborhood ?? ""
            ,"zipCode": PayQuotationData.shared.zipCode ?? ""
            ,"street": PayQuotationData.shared.street ?? ""
            ,"extNumber": PayQuotationData.shared.extNumber ?? ""
            ,"holderName": holderName
            ,"cardNumber": cardNumber
            ,"cvv": cvv
            ,"year": year
            ,"month": month
            ,"userId": PayQuotationData.shared.userId ?? 0
            ,"coverage": PayQuotationData.shared.quote?.formaPago ?? ""

        ]
        sessionDelegate.performRequest(
            showResult: false,
            queryURL: queryURL,
            method: .post,
            parameters: params,
            headers: headers,
            parseData: { data -> Document? in
                if let dataArray = data as? [String: Any] {
                    let items = Document.initWithDictionary(dataArray)
                    return items
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
