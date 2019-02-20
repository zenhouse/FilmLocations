//
//  Film.swift
//  FilmLocations
//
//  Created by John Edwards on 2/18/19.
//  Copyright © 2019 John Edwards. All rights reserved.
//

import Foundation

final class Film {
    var filmInfo: FilmInfo
    var moreInfo : MoreInfo
    
    init(_ filmInfo: FilmInfo) {
        self.filmInfo = filmInfo
        var funFacts = [String]()
        var locations = [String:Location]()
        
        // extract location info
        let location = Location(longitude: filmInfo.longitude,
                                latitude: filmInfo.latitude,
                                locName: filmInfo.location)
        let locKey = "\(location.latitude) \(location.longitude)"
        locations[locKey] = location
        
        // if fun fact exist, then extract it
        if let fact = filmInfo.funFact {
            funFacts.append(fact)
        }
       
        // init more info struct with fun facts and locations
        // we'll append additional fun facts and locations later
        self.moreInfo = MoreInfo(facts: funFacts, locations: locations)
    }
}

struct FilmInfo: Codable {
    let actors: [String]
    let longitude: Double
    let releaseYear: String
    let title: String
    let location: String
    let latitude: Double
    let writers: [String]
    let director: String
    let prodCompany: String
    var funFact: String?
    
    private enum CodingKeys : String, CodingKey {
        case actors
        case longitude
        case releaseYear = "release_year"
        case title
        case location = "locations"
        case latitude
        case writers
        case director
        case prodCompany = "production_company"
        case funFact = "fun_facts"
    }
    
}

struct Location {
    let longitude: Double
    let latitude: Double
    let locName: String
}

struct MoreInfo {
    var facts: [String]
    var locations: [String:Location]
}

