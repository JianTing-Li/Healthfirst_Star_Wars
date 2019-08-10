//
//  NetworkHelper.swift
//  Health_First_Code_Challenge
//
//  Created by Jian Ting Li on 8/10/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

final class NetworkHelper {
    private init() {}
    
    public func performDataTask(endpointURLString: String,
                                completion: @escaping (Result<Data, AppError>) -> Void) {
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        var request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                    completion(.failure(.badStatusCode(statusCode.description)))
                    return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
