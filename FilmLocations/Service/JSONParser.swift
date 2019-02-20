//
//  JSONParser.swift
//  FilmLocations
//
//  Created by John Edwards on 2/18/19.
//  Copyright © 2019 John Edwards. All rights reserved.
//

import Foundation

final class JSONParser {
    private var filmDict = [String:Film]()
    static let shared = JSONParser()
    init() {
        
    }
    
    // extract our list from the JSON
    // build dictionary aggregate same films
    func filmList(_ data: Data) -> [Film]? {
        filmDict.removeAll()
        if let filmInfoList = getList(data) {
            for filmInfo in filmInfoList {
                let key = filmInfo.title + filmInfo.director + filmInfo.releaseYear
                if filmDict[key] == nil {
                    filmDict[key] = Film(filmInfo)
                } else {
                    let location = Location(longitude: filmInfo.longitude,
                                            latitude: filmInfo.latitude,
                                            locName: filmInfo.location)
                    let locKey = "\(location.latitude) \(location.longitude)"
                    filmDict[key]?.moreInfo.locations[locKey] = location
                    
                    // append fun fact
                    if let fact = filmInfo.funFact {
                        filmDict[key]?.moreInfo.facts.append(fact)
                    }
                }
            }
        }
        
        // return list of films
        return orderedList()
    }
    
    private func getList(_ data: Data) -> [FilmInfo]? {
        do {
            let films = try JSONDecoder().decode([FilmInfo].self, from: data)
            return films
        } catch {
            print("Error occurrred retrieving JSON file: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    private func orderedList() -> [Film] {
        return filmDict.values.sorted(by: {$0.filmInfo.title < $1.filmInfo.title})
    }
    
}
