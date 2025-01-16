//
//  PersonalInfo.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 15/01/25.
//


import Foundation

struct PersonalInfo: Codable {
    var maritalStatus: [EstadoCivil]
    var genders: [Genero]
    
    enum CodingKeys: String, CodingKey {
        case maritalStatus
        case genders
    }

    static func initWithDictionary(_ dictionary: NSDictionary) -> PersonalInfo? {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let modelo = try JSONDecoder().decode(PersonalInfo.self, from: data)
            return modelo
        } catch {
            print("Error al decodificar InfoPersonal:", error)
            return nil
        }
    }
    

    
    static func initWithArray(_ array: [[String: Any]]) -> [PersonalInfo]? {
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            let modelo = try JSONDecoder().decode([PersonalInfo].self, from: data)
            return modelo
        } catch {
            print("Error al decodificar: \(error)")
            return nil
        }
    }
}

struct EstadoCivil: Codable {
    var id: String
    var name: String
    var active: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case active
    }
}

struct Genero: Codable {
    var id: String
    var name: String
    var active: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case active
    }
}
