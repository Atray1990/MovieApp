//
//  ViewController.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    
    let navigator = ListNavigatorRouting()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonClicked() {
        if searchTextField.text!.isEmpty {
            showAlertForEmpty()
        } else {
            if let navController = self.navigationController, let searchString = searchTextField.text {
                navigator.makeListViewController(searchString: searchString , from: navController)
            }
        }
    }
    
    func showAlertForEmpty() {
           let alert = UIAlertController(title: "Title", message: "enter any keyword you want to search", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler:{ (UIAlertAction)in
               print("User click Dismiss button")
           }))
           self.present(alert, animated: true, completion: {
               print("completion block")
           })
    }
}

