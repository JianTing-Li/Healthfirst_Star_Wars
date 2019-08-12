//
//  AppError.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/10/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case networkError(Error)
    case jsonDecodingError(Error)
    case badStatusCode(String)
    case propertyListDecodingError(Error)
    case propertyListEncodingError(Error)
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let str):
            return "Bad URL: \(str)"
        case .networkError(let error):
            return "Network Error: \(error)"
        case .jsonDecodingError(let error):
            return "Json Decoding Error: \(error)"
        case .badStatusCode(let message):
            return "Bad Status Code: \(message)"
        case .propertyListDecodingError(let error):
            return "Property List Decoding Error: \(error)"
        case .propertyListEncodingError(let error):
            return "Property List Encoding Error: \(error)"
        }
    }
}
