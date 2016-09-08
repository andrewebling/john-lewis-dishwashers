//
//  ProductGridCollectionViewController.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 06/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

class ProductGridCollectionViewController: UICollectionViewController {
    
    lazy var serverController: ServerController = {
        return ServerControllerImpl()
    }()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        fetchProducts()
    }
    
    func fetchProducts() {
        self.serverController.fetchProducts({ (products) in
                print(products)
            
            }) { (error) in
                print("ERROR: \(error)")
        }
    }
}

