//
//  ShowIndicator.swift
//  MovieApp
//
//  Created by Shashank on 04/04/21.
//

import Foundation
import UIKit

class showIndicator {
    
    func showLoader(view: UIView) -> UIActivityIndicatorView {
            //Customize as per your need
            let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height:40))
            spinner.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            spinner.layer.cornerRadius = 3.0
            spinner.clipsToBounds = true
            spinner.hidesWhenStopped = true
            spinner.style = UIActivityIndicatorView.Style.medium;
            spinner.center = view.center
            view.addSubview(spinner)
            view.bringSubviewToFront(spinner)
            spinner.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            return spinner
        }
}

extension UIActivityIndicatorView {
     func dismissLoader() {
            self.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
 }
