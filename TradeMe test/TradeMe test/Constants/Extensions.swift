//
//  Extensions.swift
//  TradeMe test
//
//  Created by Gopika Venugopal on 01/02/23.
//

import Foundation
import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}


extension UIViewController {
    func showLoader() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func configureItems() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                image: UIImage(named: "cart"),
                style: .done,
                target: self,
                action: #selector(addCartTapped)
            ),
            UIBarButtonItem(
                image: UIImage(named: "search"),
                style: .done,
                target: self,
                action: #selector(addSearchTapped)
            )
        ]
    }
    
    @objc func addCartTapped() {
        let alert = UIAlertController(title: "Cart", message: "Your cart is empty.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func addSearchTapped() {
        let alert = UIAlertController(title: "Search", message: "No search option available at the moment.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
