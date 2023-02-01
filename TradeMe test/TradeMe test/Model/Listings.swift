//
//  Listings.swift
//  TradeMe test
//
//  Created by Gopika Venugopal on 31/01/23.
//

import Foundation
struct Result: Codable {
    let data: [ResultItems]
}
// MARK: - ListItems

struct ResultItems: Codable {
    let Title, productImage, Region : String
    let BuyNowPrice: String
    let PriceDisplay: String
    let IsClassified, IsAuction: Bool
}
