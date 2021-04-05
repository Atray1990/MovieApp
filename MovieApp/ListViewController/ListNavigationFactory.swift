//
//  ListNavigationFactory.swift
//  PaytmInsiderTest
//
//  Created by shashank atray on 22/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

/*
    Factory class to create new classes navigational value from here, same can be done for cart screen but didnt have much to navigate there.
 */

import Foundation
import UIKit

public protocol ListNavigatable {
    func makeListViewController(searchString: String, from navController: UINavigationController)
    func makeArtistDetailViewController(from navController: UINavigationController, selectedTest:Movies)
}

extension ListNavigatable { 
    public func makeListViewController(searchString: String, from navController: UINavigationController) {
       
        navController.pushViewController(FactoryRegistrar.shared.factoryBuilder.accountFactory.makeListViewController(searchString: searchString), animated: true)
    }
    
    public func makeArtistDetailViewController(from navController: UINavigationController, selectedTest:Movies) {
        navController.pushViewController(FactoryRegistrar.shared.factoryBuilder.accountFactory.makeArtistDetailViewController(imdbRating: selectedTest.imdbID ?? ""), animated: true)
    }
    
}

open class ListNavigatorRouting: ListNavigatable {
    public init() {
        
    }
}
