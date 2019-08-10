//
//  StarWarsCharacter.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/10/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation
//o Name
//o Hair color
//o Eye color
//o Birth year
//o Date created

struct StarWarsCharactersData: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [StarWarsChatacter]
}

struct StarWarsChatacter: Codable {
    let name: String
    let hairColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let created: String
    let url: String
    private enum CodingKeys: String, CodingKey {
        case name
        case hairColor = "hair_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeworld
        case created
        case url
    }
}
