//
//  Float+priceTests.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 09/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest

class Float_priceTests: XCTestCase {

    func testExample() {
        
        let price = Float(0.99)
        XCTAssertEqual(price.asPriceString(), "£0.99")
        
        let zeroZeroPrice = Float(5.00)
        XCTAssertEqual(zeroZeroPrice.asPriceString(), "£5.00")
    }
}
