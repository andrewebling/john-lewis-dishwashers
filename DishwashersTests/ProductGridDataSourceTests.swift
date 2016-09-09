//
//  ProductGridDataSourceTests.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest

class ProductGridDataSourceFake: ProductGridDataSource {
    
    override func internalCollectionView(collectionView: UICollectionView, cellForItemAtIndexPath: NSIndexPath) -> ProductCollectionViewCell {
        return ProductCollectionViewCellFake(frame: CGRectZero)
    }
}

class ProductGridDataSourceTests: XCTestCase {
    
    let fakeCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    let fakeData = [Product](count: 42, repeatedValue: Product(productID: 4444, price: 333.66, title: "TestTitle", image: NSURL(string: "http://foobar")!))
    var dataSource: ProductGridDataSource!
    
    override func setUp() {
        super.setUp()
        
        self.dataSource = ProductGridDataSourceFake(products: self.fakeData)
        self.fakeCollectionView.dataSource = self.dataSource
        self.fakeCollectionView.registerClass(ProductCollectionViewCellFake.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseId)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNumberOfItemsInSection() {
        
        XCTAssertEqual(self.dataSource.collectionView(self.fakeCollectionView, numberOfItemsInSection: 0),
                       42)
    }
    
    func testCellForItemAtIndexPath() {
        
        let cell = self.dataSource.collectionView(self.fakeCollectionView,
                                                  cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
        
        XCTAssertTrue(cell is ProductCollectionViewCell)
    }
}
