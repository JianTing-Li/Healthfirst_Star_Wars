//
//  StarWarsPlanet.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/10/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

struct StarWarsPlanetsData: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [StarWarsPlanet]
}

struct StarWarsPlanet: Codable {
    let name: String
    let climate : String
    let population: String
    let created: String
    let url: String
    public var formattedCreationDate: String {
        let modifyDateString = created.components(separatedBy: ".").joined(separator: "+")
        return modifyDateString.formatISODateString(dateFormat: Constants.dateFormat)
    }
}
