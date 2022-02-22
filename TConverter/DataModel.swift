//
//  DataModel.swift
//  TConverter
//
//  Created by Vladislav Tuleiko on 17.02.22.
//

import Foundation

//MARK: - Main struct
struct Currency: Codable{
    var base: String = " "
    var rates: Rates = Rates()
}

//MARK: - Substruct
struct Rates: Codable{
    var BYN: Double = 0
    var EUR: Int = 0
    var RUB: Double = 0
    var USD: Double = 0
}
