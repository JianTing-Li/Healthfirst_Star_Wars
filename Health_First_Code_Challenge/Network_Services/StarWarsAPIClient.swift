//
//  StarWarsAPIClient.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/10/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

final class StarWarsAPIClient {
    private init() {}
    
    public static func getStarWarsCharacters(pageNum: Int?,
                                        searchKey: String?,
                                        completion: @escaping (Result<[StarWarsChatacter], AppError>) -> Void) {
        var urlEnpointString = "https://swapi.co/api/people/"
        if let searchKey = searchKey {
            urlEnpointString += "?search=\(searchKey)"
        } else if let pageNum = pageNum {
            urlEnpointString += "?page=\(pageNum)"
        }
        NetworkHelper.shared.performDataTask(endpointURLString: urlEnpointString) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let characters = try JSONDecoder().decode(StarWarsCharactersData.self, from: data).results
                    completion(.success(characters))
                } catch {
                    completion(.failure(.jsonDecodingError(error)))
                }
            }
        }
    }
    
    // planets
}


