//
//  QueryService.swift
//  FilmLocations
//
//  Created by John Edwards on 2/18/19.
//  Copyright © 2019 John Edwards. All rights reserved.
//

import Foundation
final class QueryService {
    
    private let strPath = "http://assets.nflxext.com/ffe/siteui/iosui/filmData.json"
    var errorMessage = ""

    // Mark: - Film
    func getURLForPath() -> URL? {
        var queryURL : URL?
        if let urlComponents = URLComponents(string: strPath) {
            queryURL = urlComponents.url
        } else {
            print("Error occured with path: \(strPath)")
        }
        return queryURL
    }
}
