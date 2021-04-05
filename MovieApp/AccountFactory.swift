
import Foundation
import UIKit

open class AccountFactory {
    
    public let accountStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    public init() {
        
    }
    
    func makeListViewController(searchString: String) -> ListViewController {
        let viewController = accountStoryboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        let requestHandler = GetDataRequestHandler()
        let navigator = ListNavigatorRouting()
        let eventHandler = ListViewEventHandler.init(viewController: viewController, requestHandler: requestHandler, navigator: navigator)
        viewController.searchText = searchString
        viewController.eventHandler = eventHandler
        return viewController
    }
    
    func makeArtistDetailViewController(imdbRating: String) -> ArtistDetailViewController  {
        let viewController = accountStoryboard.instantiateViewController(withIdentifier: "ArtistDetailViewController") as! ArtistDetailViewController
        viewController.movie = imdbRating
        let requestHandler = MovieDetailRequestHandler()
        let eventHandler = MovieEventHandler.init(viewController: viewController, requestHandler: requestHandler)
        viewController.eventHandler = eventHandler
        return viewController
    }
}

