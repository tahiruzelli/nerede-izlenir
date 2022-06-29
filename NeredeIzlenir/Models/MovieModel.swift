//
//  MovieModel.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 24.06.2022.
//

import Foundation

class Movie: Codable {
    var id: Int!
    var contentType: String?
    var title: Generic?
    var description: Generic?
    var genres: [Int]?
    var year: String?
    var yearNumber: Int?
    var people: People?
    var runtimeNumber: Int?
    var runtime: String?
    var language: [String]?
    var country: [String]?
    // Scores
    var imdb: Score?
    var tmdb: Score?
    var metascore: Score?
    var rotten: Score?
    // Stream Indo
    var streamingInfo: StreamingInfo?
    // Media
    var poster: Poster?
    var backdrops: [String]?
    var clips: [String]?
    // Series Info
    var seriesInfo: SeriesInfo?
    var url: String?
    
    static func save(value: Movie){
        var lastSearchs : [Movie] = get()
        if !lastSearchs.contains(where: {$0.tmdb?.id == value.tmdb?.id}){
            lastSearchs.append(value)
        }
        UserDefaults.standard.set(try? PropertyListEncoder().encode(lastSearchs), forKey: lastSearchsKey)
        UserDefaults.standard.synchronize()
    }
    
    static func get()-> [Movie] {
        var lastSearchs: [Movie]!
         if let data = UserDefaults.standard.value(forKey: lastSearchsKey) as? Data {
             lastSearchs = try? PropertyListDecoder().decode([Movie].self, from: data)
             return lastSearchs ?? []
         } else {
             return lastSearchs ?? []
         }
    }
    
}
struct People: Codable {
    var directors: [String]?
    var writers: [String]?
    var cast: [String]?
}
struct Poster: Codable {
    var oPoster: String?
    var tmdbPoster: Generic?
}
struct Score: Codable {
    var id: String?
    var rate: Double?
    var voteCount: Int?
    var popularity: Int?
}
struct SeriesInfo: Codable {
    var firstAirDate: String?
    var lastAirDate: String?
    var episodeRuntimes: Int?
    var seasonCount: Int?
    var episodeCount: Int?
}
struct Generic: Codable {
    var tr: String?
    var en: String?
    var original: String?
}
struct GenericArray: Codable {
    var tr: [String]?
    var en: [String]?
}
struct StreamingInfo: Codable {
    var netflix: GenericStreamInfo?
    var prime: GenericStreamInfo?
    var blutv: GenericStreamInfo?
    var puhuTv: GenericStreamInfo?
    var mubi: GenericStreamInfo?
    var appleTv: GenericStreamInfo?
    var googlePlay: GenericStreamInfo?
}
struct GenericStreamInfo: Codable {
    let tr: StreamInfo
}
struct StreamInfo: Codable {
    let link: String
}

struct SelectedPlatforms: Codable{
    var netflix: Bool = false
    var prime: Bool = false
    var blutv: Bool = false
    var puhuTv: Bool = false
    var mubi: Bool = false
    var appleTv: Bool = false
    var googlePlay: Bool = false
    
    static func isAllFalse(object : SelectedPlatforms)->Bool{
        if !object.netflix && !object.prime && !object.blutv && !object.puhuTv && !object.mubi && !object.appleTv && !object.googlePlay {
            return true
        }
        else{
            return false
        }
        
    }
}
