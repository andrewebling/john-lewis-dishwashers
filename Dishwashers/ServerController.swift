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

// code to an interface
protocol ServerController {
    func fetchProducts(_ successBlock: @escaping ([Product]) -> Void, failureBlock: @escaping (_ error: Error?) -> Void)
}

class ServerControllerImpl: ServerController {
    
    let kAPIURL = "https://api.johnlewis.com/v1/products/search"
    let kAPIKey = "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
    let kProductQuery = "dishwasher"
    let kProductCount = 20
    
    func fetchProducts(_ successBlock: @escaping ([Product]) -> Void, failureBlock: @escaping (_ error: Error?) -> Void) {
        
        let params = ["q":          kProductQuery,
                      "key":        kAPIKey,
                      "pageSize":   "\(kProductCount)"]
        
        Alamofire.request(kAPIURL, parameters: params)
            .validate().responseJSON { response in
                
                switch response.result {
                    
                case .success:
                    if let json = response.result.value {
                        do {
                            let products = try ProductParser.productsFromJSON(JSON(json))
                            successBlock(products)
                            
                        } catch {
                            
                            failureBlock(NSError(domain: "Could not load products", code: 0, userInfo: nil))
                            
                        }
                    }
                case .failure(let error):
                    
                        failureBlock(error)
                    
                }
        }
    }
}
