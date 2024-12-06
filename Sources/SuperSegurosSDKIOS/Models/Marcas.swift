//
//  Marcas.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 05/12/24.
//


import Foundation

struct Marcas: Codable {
    var id: Int
    var marca: String
    var idProductor: Int

    enum CodingKeys: String, CodingKey {
        case id = "IdMarca"
        case marca = "Marca"
        case idProductor = "idProductor"
    }

    static func initWithArray(_ array: [[String: Any]]) -> [Marcas]? {
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            let marcas = try JSONDecoder().decode([Marcas].self, from: data)
            return marcas
        } catch {
            print("Error al decodificar: \(error)")
            return nil
        }
    }
}
