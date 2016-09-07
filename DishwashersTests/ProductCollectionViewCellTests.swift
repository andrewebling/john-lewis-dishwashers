//
//  ProductCollectionViewCellTests.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest

// this is used to decouple code/tests from the Storyboard
class ProductCollectionViewCellFake: ProductCollectionViewCell {
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        self.titleLabel = UILabel(frame: CGRectZero)
        self.priceLabel = UILabel(frame: CGRectZero)
        self.imageView = UIImageView(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProductCollectionViewCellTests: XCTestCase {

    let cell = ProductCollectionViewCellFake(frame: CGRectZero)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testConfigureWithProduct() {
        
        let product = Product(productID: 12345, price: 678.90, title: "ConfiguredTitle", image: NSURL())
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_GB")
        
        self.cell.configureWithProduct(product, priceFormatter: formatter)
        
        XCTAssertEqual(cell.titleLabel.text, "ConfiguredTitle")
        XCTAssertEqual(cell.priceLabel.text, "£678.90")
        // imageView gets configured later when the image loads asynchronously
    }

}
