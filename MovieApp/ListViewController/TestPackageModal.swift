//
//  TestPackageModal.swift
//  PaytmInsiderTest
//
//  Created by shashank atray on 22/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import Foundation
import UIKit


public struct TestPackage : Decodable  {
    let Search: [Movies]?
    let totalResults: String?
    let Response: String
  
    
    // making not necessary values as optional as some data modal doesnt have them plus want to use same modal for core data
}

public struct Movies : Decodable {
    let Title: String
    let Year: String
    let imdbID: String?
    let type: String?
    let Poster: String
    
    enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, Poster
        case type = "Type"
    }
}



