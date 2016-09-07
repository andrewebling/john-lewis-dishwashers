//
//  ProductParser.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import Foundation
import SwiftyJSON

enum JSONParsingError: ErrorType {
    case InvalidProductID
    case InvalidPrice
    case InvalidTitle
    case InvalidImageURL
    case InvalidProductsArray
}

class ProductParser {
    static func singleProductFromJSON(json: JSON) throws -> Product {
        
        guard let productIDStr = json["productId"].string,
            let productID = Int(productIDStr) else {
                throw JSONParsingError.InvalidProductID
        }
        
        guard let priceStr = json["price"]["now"].string,
        let price = Float(priceStr) else {
            throw JSONParsingError.InvalidPrice
        }
        
        guard let title = json["title"].string else {
            throw JSONParsingError.InvalidTitle
        }
        
        guard let imageURLStr = json["image"].string,
            let imageURL = NSURL(string: "https:\(imageURLStr)") else {
            throw JSONParsingError.InvalidImageURL
        }
        
        return Product(productID: productID,
                       price: price,
                       title: title,
                       image: imageURL)
    }
    
    static func productsFromJSON(json: JSON) throws -> [Product] {
        
        guard let jsonProducts = json["products"].array else {
            throw JSONParsingError.InvalidProductsArray
        }
        
        var products = [Product]()
        
        jsonProducts.forEach { (productJSON) in
            
            do {
                try products.append(singleProductFromJSON(productJSON))
            } catch let error {
                /* For purposes of this exercise, simply print an error and omit problematic products from results.
                 * In a real app, this should be reported back via an endpoint or via analytics. */
                print("Product parse error at index \(jsonProducts.indexOf(productJSON)): \(error)")
            }
        }
        
        return products
    }
}