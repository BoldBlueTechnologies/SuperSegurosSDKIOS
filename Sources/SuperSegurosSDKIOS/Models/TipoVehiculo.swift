//
//  TipoVehiculo.swift
//  SuperSegurosSDKIOS
//
//  Created by Christian Martinez on 04/12/24.
//
import Foundation

struct TipoVehiculo: Codable {
    var tipoVehiculoBase: Int
    var descripcion: String

    enum CodingKeys: String, CodingKey {
        case tipoVehiculoBase = "TipoVehiculoBase"
        case descripcion = "Descripcion"
    }

    static func initWithArray(_ array: [[String: Any]]) -> [TipoVehiculo]? {
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: [])
            let tiposVehiculo = try JSONDecoder().decode([TipoVehiculo].self, from: data)
            return tiposVehiculo
        } catch {
            print("Error al decodificar: \(error)")
            return nil
        }
    }
}
