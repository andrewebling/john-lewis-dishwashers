//
//  ProductGridCollectionViewController.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 06/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

class ProductGridCollectionViewController: UICollectionViewController {
    
    private var datasource: ProductGridDataSource!
    internal lazy var serverController: ServerController = {
        return ServerControllerImpl()
    }()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchProducts()
    }
    
    private func fetchProducts() {
        
        self.serverController.fetchProducts({ products in
            
            self.configureDataSourceWithProducts(products)
            self.collectionView?.reloadData()
            
        }) { (error) in
            self.showError(error)
        }
    }
    
    private func configureDataSourceWithProducts(products: [Product]) {
        self.datasource = ProductGridDataSource(products: products)
        self.collectionView?.dataSource = self.datasource
    }
    
    private func showError(error: NSError?) {
        let ac = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(ac, animated: true, completion: nil)
    }
}

