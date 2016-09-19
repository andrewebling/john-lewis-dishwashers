//
//  UIImageView+loadURL.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 09/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadWithURL(_ url: URL) {
        self.af_setImage(withURL: url, imageTransition: .crossDissolve(0.2))
    }
}
