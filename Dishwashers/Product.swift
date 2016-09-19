//
//  Product.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import Foundation

/* struct rather than class because:
 *   - passed by value (safer)
 *   - free memberwise initialiser; less maintenance
 *   - simple enclosed values 
 *   - we don't need inheritance (yet!)
 *   - more idiomatic. */
struct Product {
    // deliberately immutable
    let productID: Int
    let price: Float
    let title: String
    let image: URL
}
