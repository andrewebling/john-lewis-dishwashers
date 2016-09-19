//
//  ProductTests.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest
import SwiftyJSON

class ProductTests: JSONIntegrationTest {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseSingleProduct() {
        let fixtureData = self.fixtureData(forResourceName: "single-product")
        let json = JSON(data: fixtureData)
        let product = try! ProductParser.singleProduct(fromJSON: json)
        
        XCTAssertEqual(product.productID, 2915517)
        XCTAssertEqual(product.price, 599.00)
        XCTAssertEqual(product.title, "Whirlpool WFO3P33DLUK Freestanding Dishwasher, WhIte")
        XCTAssertEqual(product.image.absoluteString, "https://johnlewis.scene7.com/is/image/JohnLewis/236331171?")
    }
    
    func testParseProducts() {
        let fixtureData = self.fixtureData(forResourceName: "product-grid-response")
        let json = JSON(data: fixtureData as Data)
        let products = try! ProductParser.products(fromJSON: json)
        
        XCTAssertEqual(products.count, 20)
        
        guard let product = products.last else {
            XCTFail("No last object in returned products array")
            return
        }
        
        XCTAssertEqual(product.productID, 2641341)
        XCTAssertEqual(product.price, 679.00)
        XCTAssertEqual(product.title, "Miele G4720 SC Slimline Freestanding Dishwasher, White")
        XCTAssertEqual(product.image.absoluteString, "https://johnlewis.scene7.com/is/image/JohnLewis/235997186?")
    }
}
