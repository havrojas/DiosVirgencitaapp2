//dios
//virgencita y san jose
//santso y angeles de dios
//  peticion.swift
//  diosvirgencita
//
//  Created by Havit on 31/07/26.
//

import Foundation
struct Peticion: Identifiable {
    let id = UUID()
    let nombre: String
    let motivo: String
    let fecha: String
    var oracionesCount: Int
    var yaOro: Bool = false
}
