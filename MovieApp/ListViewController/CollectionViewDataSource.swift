//
//  CollectionViewDataSource.swift
//  FlickerUIViewProject
//
//  Created by shashank atray on 08/08/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import Foundation
import UIKit


class CollectionViewDataSource: NSObject, UICollectionViewDataSource  {
    
    var moviesList: [Movies]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let albumValues = moviesList {
            return albumValues.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bodyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell",for: indexPath) as! collectionViewCell
        
        bodyCell.setupWithPhoto(album: self.moviesList![indexPath.row] )
        return bodyCell
    }
    
   
    
    
}
