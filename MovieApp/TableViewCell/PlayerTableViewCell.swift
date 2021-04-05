
//
//  collectionViewCell.swift
//  PaytmInsiderTest
//
//  Created by shashank atray on 22/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import UIKit


class collectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblimdbID: UILabel!
    @IBOutlet weak var ivAlbumImage: UIImageView!
    @IBOutlet weak var lblGenre: UILabel!

    @IBOutlet weak var viewContainer: UIView!
        
    var imageLoader = ImageLoader()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cellSetup() {  // this can be created in seperate extention to be reused as desired
        viewContainer.layer.cornerRadius = 6.0
        viewContainer.layer.borderWidth = 1.0
        viewContainer.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true

       /* layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: viewContainer.layer.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor*/
        ivAlbumImage.layer.cornerRadius = 2
    }
    
    func setupWithPhoto(album: Movies) {
        cellSetup()
        lblMovieName.text = album.Title
        if let type = album.type {
            lblGenre.text = "Type : \(type)"
        }
       
        if let imdbID = album.imdbID {
            lblimdbID.text = "imdbID : \(imdbID)"
        }
       
        imageLoader.obtainImageWithPath(imagePath: album.Poster) { (image) in
            self.ivAlbumImage.image = image
        }
    }
}
