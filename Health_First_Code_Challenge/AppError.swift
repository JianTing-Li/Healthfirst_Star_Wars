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
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let str):
            return "badURL: \(str)"
        case .networkError(let error):
            return "networkError: \(error)"
        case .jsonDecodingError(let error):
            return "json decoding error: \(error)"
        case .badStatusCode(let message):
            return "bad status code: \(message)"
        }
    }
}
