//
//  Parser.swift
//  TradeMe test
//
//  Created by Gopika Venugopal on 31/01/23.
//

import Foundation

struct Parser {
    
    func parseJSON(completionHandler: @escaping (_ items: Result?, _ error: Error?) -> Void) {
        guard let path = Bundle.main.path(forResource: "mockData", ofType: "json") else {
            completionHandler(nil, "Something went wrong" as? Error)
            return
        }
        let url = URL(fileURLWithPath: path)
        var result: Result?
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(Result.self, from: jsonData)
            print(result)
            completionHandler(result, nil)
            return
        } catch {
            completionHandler(nil, error)
            print("Error: \(error)")
            return
        }
    }
    
    // Mock API
    func parse (completionHandler: @escaping (_ items: Result?, _ error: Error?) -> Void) {
        
        var request = URLRequest(url: URL(string: "https://api.tmsandbox.co.nz/v1/listings/latest.json?oauth_signature_%20method=PLAINTEXT")!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("OAuth oauth_consumer_key=\"A1AC63F0332A131A78FAC304D007E7D1\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1675128396\",oauth_nonce=\"OpoQNEOoylA\",oauth_version=\"1.0\",oauth_signature=\"yBSvQxMcLkS6iv7FLKzXbh4DDa0%3D\"", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                completionHandler(nil, error)
                return
            }
            do {
                
                
                
                
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                    
                    var listItems : Result?
                    guard let lisitngItems = convertedJsonIntoDict["List"] as? [[String: AnyObject]] else {
                        print("Something wrong!!")
                        completionHandler(nil, error)
                        return
                    }
                    
                    for item in lisitngItems {
                        let Title = item["Title"] as? String ?? ""
                        let PictureHref = item["PictureHref"] as? String ?? ""
                        let Region = item["Region"] as? String ?? ""
                        let BuyNowPrice = item["BuyNowPrice"] as? String ?? ""
                        let PriceDisplay = item["PriceDisplay"] as? String ?? ""
                        let IsClassified = item["IsClassified"] as? Bool ?? false
                        let newList = ResultItems(Title: Title, productImage: PictureHref, Region: Region, BuyNowPrice: BuyNowPrice, PriceDisplay: PriceDisplay, IsClassified: IsClassified, IsAuction: false)
                        let temprepo = [newList]
                        //                                listItems.data.append(contentsOf: temprepo)
                        
                    }
                    completionHandler(listItems, nil)
                    return
                    
                }
                
                
                
            } catch {
                completionHandler(nil, error)
                print("Something went wrong!!")
            }
        }
        task.resume()
        
    }
    
    
}
