//
//  Address.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 14/01/25.
//
// Address.swift
import Foundation

struct Address: Codable {
    let codigo_postal: String?
    let municipio: Municipio?
    let estado: Estado?
    let ciudad: Ciudad?
    let colonias: [Colonia]?
    
    struct Municipio: Codable {
        let clave: String?
        let nombre: String?
    }
    
    struct Estado: Codable {
        let clave: String?
        let nombre: String?
    }
    
    struct Ciudad: Codable {
        let clave: String?
        let nombre: String?
    }
    
    struct Colonia: Codable {
        let id: Int?
        let id_asenta: String?
        let colonia: String?
        let zona: String?
        let sepomex: Sepomex?
    }
    
    struct Sepomex: Codable {
        let tipo: String?
        let clave_tipo: String?
    }
    
    
    static func initWithDictionary(_ dictionary: NSDictionary) -> Address? {
        
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            let addresses = try JSONDecoder().decode(Address.self, from: data)
            return addresses
        } catch {
            print("Error al decodificar Address: \(error.localizedDescription)")
            return nil
        }
    }

    static func initWithArray(_ array: [[String: Any]]) -> Address? {
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            let addresses = try JSONDecoder().decode(Address.self, from: data)
            return addresses
        } catch {
            print("Error al decodificar Address: \(error.localizedDescription)")
            return nil
        }
    }
}
