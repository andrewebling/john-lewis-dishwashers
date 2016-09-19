//
//  ProductViewController.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 09/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

// used to decouple from other view controllers
protocol ProductViewer {
    var product: Product? { get set }
}

class ProductViewController:UIViewController, ProductViewer {

    var product: Product?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let product = self.product {
            configure(withProduct: product)
        }
    }
    
    fileprivate func configure(withProduct product: Product) {
        self.navigationItem.title = product.title
        self.priceLabel.text = product.price.asPriceString()
        self.imageView.load(withURL: product.image)
    }
}
