//
//  MovieEventHandler.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//

import Foundation

import UIKit
import CoreData

open class MovieEventHandler {
    let apiKey = "7d58cc52"
    
    weak var viewController: ArtistDetailViewController?
    let requestHandler: MovieDetailRequestHandler
    
    init(viewController: ArtistDetailViewController, requestHandler: MovieDetailRequestHandler) {
        self.viewController = viewController
        self.requestHandler = requestHandler
    }
    
    func fetchMoviedata(movieID: String) {
        let url = URL(string: "http://www.omdbapi.com/?i=\(movieID)&apikey=\(apiKey)")!
        requestHandler.requestForMovieDataWith(requestUrl: url) { (result) in
            switch result {
            case .success(let movieData):
                self.viewController?.setupWithData(movie: movieData)
            case .failure(_ ):
                print("anything")
            }
        }
    }
}
