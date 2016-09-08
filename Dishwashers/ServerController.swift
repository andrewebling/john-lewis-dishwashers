//
//  ServerController.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 08/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ServerController {
    func fetchProducts(successBlock: ([Product]) -> Void, failureBlock: (error: NSError?) -> Void)
}

class ServerControllerImpl: ServerController {
    
    let kAPIURL = "https://api.johnlewis.com/v1/products/search"
    let kAPIKey = "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
    let kProductQuery = "dishwasher"
    let kProductCount = 20
    
    func fetchProducts(successBlock: ([Product]) -> Void, failureBlock: (error: NSError?) -> Void) {
        
        let params = ["q":          kProductQuery,
                      "key":        kAPIKey,
                      "pageSize":   "\(kProductCount)"]
        
        Alamofire.request(.GET, kAPIURL, parameters: params)
            .validate().responseJSON { response in
                
                switch response.result {
                    
                case .Success:
                    if let json = response.result.value {
                        do {
                            let products = try ProductParser.productsFromJSON(JSON(json))
                            dispatch_async(dispatch_get_main_queue(), {
                                successBlock(products)
                            })
                        } catch {
                            dispatch_async(dispatch_get_main_queue(), {
                                failureBlock(error: NSError(domain: "Could not load products", code: 0, userInfo: nil))
                            })
                        }
                    }
                case .Failure(let error):
                    dispatch_async(dispatch_get_main_queue(), {
                        failureBlock(error: error)
                    })
                }
        }
    }
}