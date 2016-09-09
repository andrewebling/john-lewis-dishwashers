//
//  UIImageView+loadURL.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 09/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadWithURL(url: NSURL) {
        self.af_setImageWithURL(url, imageTransition: .CrossDissolve(0.2))
    }
}
