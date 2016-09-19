//
//  ProductGridDataSource.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

class ProductGridDataSource: NSObject {

    fileprivate let products: [Product]
    
    init(products: [Product]) {
        self.products = products
        super.init()
    }
    
    func internalCollectionView(_ collectionView: UICollectionView, cellForItemAtIndexPath indexPath: IndexPath) -> ProductCollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath)
            as? ProductCollectionViewCell else {
                
            preconditionFailure("Collection view configured with wrong type of cell")
        }
        
        return cell
    }
    
    internal func productForIndexPath(_ indexPath: IndexPath) -> Product? {
        
        // in theory impossible, but being defensive
        guard (indexPath as NSIndexPath).row < self.products.count else {
            return nil
        }
        return self.products[(indexPath as NSIndexPath).row]
    }
}

extension ProductGridDataSource: UICollectionViewDataSource {
    
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = internalCollectionView(collectionView, cellForItemAtIndexPath: indexPath)
        
        if let product = productForIndexPath(indexPath) {
            
            cell.configure(withProduct: product)
            cell.configureLookAndFeel()
        }
        
        return cell
    }
}
