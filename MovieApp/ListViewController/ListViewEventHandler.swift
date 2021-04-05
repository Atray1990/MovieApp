//
//  ListViewEventHandler.swift
//  TestProjectData
//
//  Created by shashank atray on 13/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/  
//

import Foundation
import UIKit
import CoreData

open class ListViewEventHandler {
    let apiKey = "7d58cc52"
    
    weak var viewController: ListViewController?
    let navigator: ListNavigatorRouting
    let requestHandler: GetDataRequestHandler
    
    init(viewController: ListViewController, requestHandler: GetDataRequestHandler, navigator: ListNavigatorRouting) {
        self.viewController = viewController
        self.requestHandler = requestHandler
        self.navigator = navigator
    }
    
    func fetchChatdata(searchText: String, pageCount:Int) {
            let url = URL(string: "http://www.omdbapi.com/?apikey=\(apiKey)&s=\(searchText)&page=\(pageCount)")!
           
            requestHandler.requestForUserDataWith(requestUrl: url) { (result) in
                switch result {
                case .success(let movieData):
                    self.viewController?.showMovie(movie: movieData, searchtext:searchText)
                case .failure(_ ):
                    self.viewController?.handleError()
                }
            }
        }
    
    func moveToArtistDetailScreen(navController: UINavigationController, selectedTest:Movies) {
        navigator.makeArtistDetailViewController(from: navController, selectedTest: selectedTest)
    }
    
}
