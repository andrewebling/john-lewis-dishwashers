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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? UICollectionViewCell,
            let indexPath = self.collectionView?.indexPathForCell(cell),
            let product = self.datasource.productForIndexPath(indexPath),
            var productViewer = segue.destinationViewController as? ProductViewer {
            
            productViewer.product = product
        }
    }
    
    private func fetchProducts() {
        
        self.serverController.fetchProducts({ products in
            
            self.configureDataSourceWithProducts(products)
            self.collectionView?.reloadData()
            self.navigationItem.title = "Dishwashers (\(products.count))"
        }) { (error) in
            self.showError(error)
        }
    }
    
    private func configureDataSourceWithProducts(products: [Product]) {
        self.datasource = ProductGridDataSource(products: products)
        self.collectionView?.dataSource = self.datasource
    }
}

extension UIViewController {
    func showError(error: NSError?) {
        self.presentViewController(alertControllerWithError(error), animated: true, completion: nil)
    }
    
    private func alertControllerWithError(error: NSError?) -> UIAlertController {
        let ac = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        return ac
    }
}