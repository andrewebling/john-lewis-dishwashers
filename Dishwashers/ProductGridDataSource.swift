//
//  ProductGridDataSource.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

class ProductGridDataSource: NSObject, UICollectionViewDataSource {

    let products: [Product]
    
    init(products: [Product]) {
        self.products = products
        super.init()
    }
    
    @objc func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    @objc func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = internalCollectionView(collectionView, cellForItemAtIndexPath: indexPath)
        
        return cell
    }
    
    internal func internalCollectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ProductCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ProductCollectionViewCell.reuseId, forIndexPath: indexPath) as? ProductCollectionViewCell else {
            preconditionFailure("Collection view configured with wrong type of cell")
        }
        
        return cell
    }
}
