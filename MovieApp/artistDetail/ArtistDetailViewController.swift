//
//  ArtistDetailViewController.swift
//  MovieApp
//
//  Created by shashank atray on 04/04/21.
//  Copyright © 2020 shashank atray. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ArtistDetailViewController: UIViewController {
    
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblMovieType: UILabel!
    @IBOutlet weak var lblRuntime: UILabel!
    @IBOutlet weak var lblProduction: UILabel!
    @IBOutlet weak var lblimdbVotes: UILabel!
    @IBOutlet weak var lblWriter: UILabel!
    @IBOutlet weak var lblGenere: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblActors: UILabel!
    @IBOutlet weak var ivMovieImage: UIImageView!
    var movie = ""
    var imageLoader = ImageLoader()
    
    var eventHandler: MovieEventHandler!
    
    var artistAlbum: Movies!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        eventHandler.fetchMoviedata(movieID: movie)
        
    }
    
    func setUp() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(popBack))
    }
    
    @objc func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupWithData(movie: Movie) {
        navigationItem.title = movie.Title
        lblMovieName.text = movie.Title
        lblMovieType.text = movie.type
        lblGenere.text = movie.Genre
        lblActors.text = movie.Actors
        lblProduction.text = movie.Production
        if let votes =  movie.imdbVotes {
            lblimdbVotes.text = "\(votes)"
        }
        
        lblWriter.text = movie.Writer
        lblReleaseDate.text = movie.Released
        lblRuntime.text = movie.Runtime
        if let poster = movie.Poster {
            imageLoader.obtainImageWithPath(imagePath: poster) { (image) in
                self.ivMovieImage.image = image
            }
        } else {
            self.ivMovieImage.backgroundColor = UIColor.red
        }
        getDateFormat()
        
    }
    
    func getDateFormat() {
        let formater = ISO8601DateFormatter()
        formater.formatOptions = [.withFullDate]
        let date = formater.date(from: "")
        if let dateValue = date {
            //lblReleaseDate.text = "\(dateValue))"
        }
    }
    
}


