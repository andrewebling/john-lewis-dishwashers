//
//  ProductGridCollectionViewController.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 06/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

class ProductGridCollectionViewController: UICollectionViewController {
    
    fileprivate var datasource: ProductGridDataSource!
    internal lazy var serverController: ServerController = {
        return ServerControllerImpl()
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchProducts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
            let indexPath = self.collectionView?.indexPath(for: cell),
            let product = self.datasource.product(forIndexPath: indexPath),
            var productViewer = segue.destination as? ProductViewer {
            
            productViewer.product = product
        }
    }
    
    fileprivate func fetchProducts() {
        
        self.serverController.fetchProducts({ products in
            
            self.configureDataSource(withProducts: products)
            self.collectionView?.reloadData()
            self.navigationItem.title = "Dishwashers (\(products.count))"
        }) { (error) in
            self.show(error)
        }
    }
    
    fileprivate func configureDataSource(withProducts products: [Product]) {
        self.datasource = ProductGridDataSource(products: products)
        self.collectionView?.dataSource = self.datasource
    }
}

extension UIViewController {
    func show(_ error: Error?) {
        self.present(alertController(withError: error), animated: true, completion: nil)
    }
    
    fileprivate func alertController(withError error: Error?) -> UIAlertController {
        let ac = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return ac
    }
}
