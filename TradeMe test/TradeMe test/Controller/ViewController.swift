//
//  ViewController.swift
//  TradeMe test
//
//  Created by Gopika Venugopal on 31/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    let parser = Parser()
    var result: Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        self.showLoader()
        self.parser.parseJSON{ prodList, error in
            self.dismiss(animated: false, completion: nil)
            if let listItems = prodList {
                self.result = listItems
            }
            
            
            self.listTableView.reloadData()
            self.listTableView.dataSource = self
            self.listTableView.delegate = self
            
            
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListingsTableViewCell
        
        if result!.data[indexPath.row].IsClassified {
            cell.titleLabel.text = result!.data[indexPath.row].Title
            cell.regionLabel.text = result!.data[indexPath.row].Region
            cell.productImageView.image = UIImage(named: result!.data[indexPath.row].productImage)
            cell.displayPriceLabel.text = result!.data[indexPath.row].PriceDisplay
            cell.reserveLabel.text = "Reserve met"
            
            
        } else {
            cell.titleLabel.text = result!.data[indexPath.row].Title
            cell.regionLabel.text = result!.data[indexPath.row].Region
            cell.productImageView.image = UIImage(named: result!.data[indexPath.row].productImage)
            cell.displayPriceLabel.text = result!.data[indexPath.row].PriceDisplay
            cell.buyNowPriceLabel.text = result!.data[indexPath.row].BuyNowPrice
            cell.reserveLabel.text = "No reserve"
            cell.buyNowLabel.text = "Buy Now"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Sorry",
                                      message: "\(result!.data[indexPath.row].Title) is not available.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok",
                                      style: .default,
                                      handler: nil))
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
