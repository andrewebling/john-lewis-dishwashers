//
//  ProductCollectionViewCell.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductCollectionViewCell: UICollectionViewCell {
    static let reuseId = "ProductCollectionViewCellReuseId"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    func configureWithProduct(product: Product) {
        self.titleLabel.text = product.title
        self.priceLabel.text = product.price.asPriceString()
        self.imageView.loadWithURL(product.image)    }
    
    func configureLookAndFeel() {
        self.layer.borderColor = UIColor(red: 0.867, green: 0.851, blue: 0.820, alpha: 1.00).CGColor
        self.layer.borderWidth = 0.5
    }
}
