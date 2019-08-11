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
                                        completion: @escaping (Result<StarWarsCharactersData, AppError>) -> Void) {
        var urlEndpointString = "https://swapi.co/api/people/"
        if let searchKey = searchKey {
            urlEndpointString += "?search=\(searchKey)"
        } else if let pageNum = pageNum {
            urlEndpointString += "?page=\(pageNum)"
        }
        NetworkHelper.shared.performDataTask(endpointURLString: urlEndpointString) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let charactersData = try JSONDecoder().decode(StarWarsCharactersData.self, from: data)
                    completion(.success(charactersData))
                } catch {
                    completion(.failure(.jsonDecodingError(error)))
                }
            }
        }
    }
    
    public static func getStarWarsPlanets(pageNum: Int?,
                                          searchKey: String?,
                                          completion: @escaping (Result<StarWarsPlanetsData, AppError>) -> Void) {
        var urlEndpointString = "https://swapi.co/api/planets/"
        if let searchKey = searchKey {
            urlEndpointString += "?search=\(searchKey)"
        } else if let pageNum = pageNum {
            urlEndpointString += "?page=\(pageNum)"
        }
        NetworkHelper.shared.performDataTask(endpointURLString: urlEndpointString) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                do {
                    let planetsData = try JSONDecoder().decode(StarWarsPlanetsData.self, from: data)
                    completion(.success(planetsData))
                } catch {
                    completion(.failure(.jsonDecodingError(error)))
                }
            }
        }
    }
}


