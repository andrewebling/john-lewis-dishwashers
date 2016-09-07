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
}