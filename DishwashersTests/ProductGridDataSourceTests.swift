//
//  ProductGridDataSourceTests.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest

class ProductGridDataSourceTests: XCTestCase {
    
    let fakeData = [Product](count: 42, repeatedValue: Product(productID: 0, price: 0.0, title: "", image: NSURL()))
    var dataSource: ProductGridDataSource!
    
    override func setUp() {
        super.setUp()
        
        self.dataSource = ProductGridDataSource(products: self.fakeData)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNumberOfItemsInSection() {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        XCTAssertEqual(self.dataSource.collectionView(collectionView, numberOfItemsInSection: 0),
                       42)
    }
}
