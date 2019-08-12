//
//  StarWarsCharacter.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/10/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

struct StarWarsPeopleData: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [StarWarsPerson]
}

struct StarWarsPerson: Codable {
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
    public var formattedCreationDate: String {
        let modifyDateString = created.components(separatedBy: ".").joined(separator: "+")
        return modifyDateString.formatISODateString(dateFormat: Constants.dateFormat)
    }
    public var flashcardDiscription: String {
        return """
        Birth Year: \(birthYear)
        Hair Color:\(hairColor)
        Eye Color: \(eyeColor)
        Date Created: \(formattedCreationDate)
        """
    }
}
