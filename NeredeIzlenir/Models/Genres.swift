//
//  Genres.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 27.06.2022.
//

import Foundation

enum Genres : Int, Codable, CustomStringConvertible, CaseIterable {
    case Action = 28
    case Adventure = 12
    case Animation = 16
    case Biography = 1
    case Comedy = 35
    case Crime = 80
    case Documentary = 99
    case Drama = 18
    case Family = 10751
    case Fantasy = 14
    case Film_Noir = 2
    case History = 36
    case Horror = 27
    case Music = 13
    case Musical = 10402
    case Mystery = 9648
    case Romance = 10749
    case Sci_Fi = 878
//    case Short_Film = 6
    case Sport = 5
//    case Superhero = 20
    case Thriller = 53
    case War = 10752
    case Western = 37
//    case Game_Show = 3
    case News = 10763
    case Reality_TV = 10764
    case Talk_Show = 10767
    public var description: String {
        let value = String(format:"%02X", rawValue)
        return "Command Type = 0x" + value + ", \(name)"
    }
    public var name: String {
        switch self {
        case .Action : return "Action"
        case .Adventure : return "Adventure"
        case .Animation : return "Animation"
        case .Biography : return "Biography"
        case .Comedy : return "Comedy"
        case .Crime : return "Crime"
        case .Documentary : return "Documentary"
        case .Drama : return "Drama"
        case .Family : return "Family"
        case .Fantasy : return "Fantasy"
        case .Film_Noir : return "Film-Noir"
        case .History : return "History"
        case .Horror : return "Horror"
        case .Music : return "Music"
        case .Musical : return "Musical"
        case .Mystery : return "Mystery"
        case .Romance : return "Romance"
        case .Sci_Fi : return "Sci-Fi"
//        case .Short_Film : return "Short-Film"
        case .Sport : return "Sport"
//        case .Superhero : return "Superhero"
        case .Thriller : return "Thriller"
        case .War : return "War"
        case .Western : return "Western"
//        case .Game_Show : return "Game-Show"
        case .News : return "News"
        case .Reality_TV : return "Reality-TV"
        case .Talk_Show : return "Talk-Show"
        }
    }
    public var nameTr: String {
        switch self {
        case .Action : return "Aksiyon"
        case .Adventure : return "Macera"
        case .Animation : return "Animasyon"
        case .Biography : return "Biyografi"
        case .Comedy : return "Komedi"
        case .Crime : return "Suç"
        case .Documentary : return "Belgesel"
        case .Drama : return "Drama"
        case .Family : return "Aile"
        case .Fantasy : return "Fantastik"
        case .Film_Noir : return "Film-Noir"
        case .History : return "Tarih"
        case .Horror : return "Korku"
        case .Music : return "Müzik"
        case .Musical : return "Müzikal"
        case .Mystery : return "Gizem"
        case .Romance : return "Romantik"
        case .Sci_Fi : return "Bilim Kurgu"
//        case .Short_Film : return "Kısa Film"
        case .Sport : return "Spor"
//        case .Superhero : return "Süper Kahraman"
        case .Thriller : return "Gerilim"
        case .War : return "Savaş"
        case .Western : return "Vahşi Batı"
//        case .Game_Show : return "Game-Show"
        case .News : return "Haber"
        case .Reality_TV : return "Reality-TV"
        case .Talk_Show : return "Talk-Show"
        }
    }
}

struct Genre : Codable {
    var title : String?
    var id : Int?
    var isSelected : Bool = false
    
    static func createGenre()-> [Genre]{
        var genres : [Genre] = []
        genres.append(Genre(title: "Action", id: 28, isSelected: false))
        genres.append(Genre(title: "Adventure", id: 12, isSelected: false))
        genres.append(Genre(title: "Animation", id: 16, isSelected: false))
        genres.append(Genre(title: "Biography", id: 1, isSelected: false))
        genres.append(Genre(title: "Comedy", id: 35, isSelected: false))
        genres.append(Genre(title: "Crime", id: 80, isSelected: false))
        genres.append(Genre(title: "Documentary", id: 99, isSelected: false))
        genres.append(Genre(title: "Drama", id: 18, isSelected: false))
        genres.append(Genre(title: "Family", id: 10751, isSelected: false))
        genres.append(Genre(title: "Fantasy", id: 14, isSelected: false))
        genres.append(Genre(title: "Film_Noir", id: 2, isSelected: false))
        genres.append(Genre(title: "History", id: 36, isSelected: false))
        genres.append(Genre(title: "Horror", id: 27, isSelected: false))
        genres.append(Genre(title: "Music", id: 13, isSelected: false))
        genres.append(Genre(title: "Musical", id: 10402, isSelected: false))
        genres.append(Genre(title: "Mystery", id: 9648, isSelected: false))
        genres.append(Genre(title: "Romance", id: 10749, isSelected: false))
        genres.append(Genre(title: "Sci_Fi", id: 878, isSelected: false))
        genres.append(Genre(title: "Sport", id: 5, isSelected: false))
        genres.append(Genre(title: "Thriller", id: 53, isSelected: false))
        genres.append(Genre(title: "War", id: 10752, isSelected: false))
        genres.append(Genre(title: "Western", id: 37, isSelected: false))
        genres.append(Genre(title: "News", id: 10763, isSelected: false))
        genres.append(Genre(title: "Reality_TV", id: 10764, isSelected: false))
        genres.append(Genre(title: "Talk_Show", id: 10767, isSelected: false))
        return genres
    }

    static func isAllFalse(object : [Genre])->Bool{
        for item in object {
            if item.isSelected {
                return true
            }
        }
        return false
    }
    
    static func getSelectedGenreIds(object: [Genre])->[Int] {
        var genres : [Int] = []
        for item in object{
            if item.isSelected {
                genres.append(item.id ?? 0)
            }
        }
        return genres
    }

}


