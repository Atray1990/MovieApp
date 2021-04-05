//
//  ListViewController.swift
//  PaytmInsiderTest
//
//  Created by shashank atray on 22/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    // lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 10, y: 5, width: 250, height: 25))
    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var errorView: UIView!
    
    let collectionDataSource = CollectionViewDataSource()
    var eventHandler: ListViewEventHandler!
    var moviesList: [Movies] = []
    var searchText: String?
    var pagecount = 1
    var spinner: UIActivityIndicatorView!
    private var searchDebouncer: Debouncer?
    
    private enum Constants {
        static let searchDelay: TimeInterval = 2.0
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        collectionViewSetUp(count: 2)
        if let search = searchText {
            eventHandler.fetchChatdata(searchText: search, pageCount: pagecount)
        }
        self.errorView.isHidden = true
       
    }
    
    func setUpViews() {
        searchBar.placeholder = "search Movie"
        searchBar.delegate = self
        
        self.collectionView.dataSource = collectionDataSource
        self.collectionView.reloadData()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "GridType", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(popBack))
        navigationItem.title = "Search Artist/Song"
    }
    
    @objc func addTapped(){
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Show 2 per row", style: .default , handler:{ (UIAlertAction)in
            self.collectionViewSetUp(count: 2)
        }))
        
        alert.addAction(UIAlertAction(title: "Show 1 per row", style: .default , handler:{ (UIAlertAction)in
            self.collectionViewSetUp(count: 1)
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func collectionViewSetUp(count: CGFloat) {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        
        if count == 1 {
            layout.itemSize = CGSize(width: (self.view.frame.width - 20)/count, height: 180)
        } else {
            layout.itemSize = CGSize(width: (self.view.frame.width - 20)/count, height: (self.view.frame.width - 20)/count)
        }
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView.reloadData()
        collectionView!.collectionViewLayout = layout
        
    }
    
    func showMovie(movie: TestPackage, searchtext: String) {
        if let spinner = spinner {
            spinner.dismissLoader()
            spinner.removeFromSuperview()
        }
       
        if movie.Response == "False" {
            self.errorView.isHidden = false
            self.collectionView.isHidden = true
        } else {
            self.errorView.isHidden = true
            self.collectionView.isHidden = false
            
            if pagecount > 1 {
                if let movies = movie.Search {
                    self.moviesList = moviesList + movies
                }
               
            } else {
                if let movies = movie.Search {
                    self.moviesList = movies
                }
            }
            self.collectionDataSource.moviesList = moviesList
            DispatchQueue.main.async {
               
                self.collectionView.reloadData()
            }
        }
    }
    
    func handleError() {
        self.errorView.isHidden = false
        self.collectionView.isHidden = true
        self.spinner.dismissLoader()
    }
    
    func moveToArtistScreenScreen(testData: Movies) {
        if let navController = self.navigationController {
            eventHandler.moveToArtistDetailScreen(navController: navController, selectedTest: testData)
        }
    }
    
    @objc func popBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func retryButtonClicked() {
        pagecount = 1
        eventHandler.fetchChatdata(searchText: searchText!, pageCount: pagecount)
    }
    
    func showSpinner() {
        spinner = showIndicator().showLoader(view: self.view)
    }
    
}

// MARK:- delegates of search bar
extension ListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /*guard searchText.count > 2 else {
            return
        }*/
       var debounceHandler: () -> Void = { [weak self] in
            self?.pagecount = 1
            self?.eventHandler.fetchChatdata(searchText: searchText, pageCount: 1)
        }
        
        guard let searchDebouncer = self.searchDebouncer else {
            // setup debouncer
            let debouncer = Debouncer(delay: Constants.searchDelay, handler: {})
            self.searchDebouncer = debouncer
            return
        }
        
        // invalidate the current debouncer so that it doesn't execute the old handler
        searchDebouncer.invalidate()
        searchDebouncer.handler = debounceHandler
        searchDebouncer.call()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text!.count > 2 else {
            return
        }
        self.pagecount = 1
        eventHandler.fetchChatdata(searchText: searchBar.text!, pageCount: pagecount)
    }
    
}

// MARK:- delegate for collection view
extension ListViewController: UICollectionViewDelegate {
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.moveToArtistScreenScreen(testData: moviesList[indexPath.row])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let lastItem = self.moviesList.count - 1
                if indexPath.row == lastItem {
                    pagecount = pagecount + 1
                    eventHandler.fetchChatdata(searchText: searchText!, pageCount: pagecount)
                    showSpinner()
            }
        }
}


