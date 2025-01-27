//
//  BasicQuotation.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 06/12/24.
//


import Foundation

struct BasicQuotation: Codable {
    var aseguradora: String
    var nombre: String
    var imagen: String
    var monto: String

    enum CodingKeys: String, CodingKey {
        case aseguradora = "aseguradora"
        case nombre = "nombre"
        case imagen = "img"
        case monto = "monto"
    }

    static func initWithArray(_ array: [[String: Any]]) -> [BasicQuotation]? {
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            let bq = try JSONDecoder().decode([BasicQuotation].self, from: data)
            return bq
        } catch {
            print("Error al decodificar: \(error)")
            return nil
        }
    }
}
