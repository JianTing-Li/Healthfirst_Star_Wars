//
//  Flashcard.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/12/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

enum Category {
    case character
    case planet
}

struct Flashcard: Codable {
    let type: String
    let name: String
    let description: String
}
