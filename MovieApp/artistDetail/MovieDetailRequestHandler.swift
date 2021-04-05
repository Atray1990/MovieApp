//
//  MovieDetailRequestHandler.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//

import Foundation

public protocol MovieDetailRequestHandlerUseCase {
func requestForMovieDataWith(requestUrl: URL, completionHandler:  @escaping (Results<Movie, CAError>)->())}

extension MovieDetailRequestHandlerUseCase {
    
    public func requestForMovieDataWith(requestUrl: URL, completionHandler:  @escaping (Results<Movie, CAError>)->()) {
        
        ApiServiceCall.shared.call(param: nil, service: requestUrl, method: .get, urlString: requestUrl.absoluteString) { (response) in
            switch response{
            case .success(let data):
                do {
                    if let parsed = try? JSONDecoder().decode(Movie.self, from: data!) {
                       completionHandler(.success(parsed))
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

public struct MovieDetailRequestHandler: MovieDetailRequestHandlerUseCase {
    public init() {}
}
