//
//  NetworkService.swift
//  FilmLocations
//
//  Created by John Edwards on 2/18/19.
//  Copyright © 2019 John Edwards. All rights reserved.
//

import Foundation

final class NetworkService {
    
    typealias NetworkResult = (Data?, String) ->()
    var errorMessage = ""
    
    
    func dataForURL(_ url: URL?, completion: @escaping NetworkResult ) {
        guard let url = url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                self.errorMessage += "DataTask error " + error.localizedDescription
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                DispatchQueue.main.async {
                    completion(data, self.errorMessage)
                }
            }
        }
            .resume()
    }
}
