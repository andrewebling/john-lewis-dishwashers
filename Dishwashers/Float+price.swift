//
//  Float+price.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 09/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import Foundation

extension Float {
    func asPriceString() -> String {
        return String(format: "£%.2f", self)
    }
}