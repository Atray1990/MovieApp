//
//  MovieModal.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//


import Foundation
import UIKit

public struct Movie: Decodable  {
    
    let Title: String
    let type: String?
    let Runtime: String?
    let Response: String
    let Rated: String?
    let Production: String?
    let Poster: String?
    let Plot: String?
    let Language: String?
    let imdbRating: String?
    let Genre: String?
    let Writer: String?
    let imdbVotes: String?
    let Actors: String?
    let Released: String?
    
    enum CodingKeys: String, CodingKey {
        case Title, Runtime, Response, Rated, Production, Poster, Plot, Language, imdbVotes,imdbRating, Genre, Writer, Actors, Released
        case type = "Type"
    }
}

