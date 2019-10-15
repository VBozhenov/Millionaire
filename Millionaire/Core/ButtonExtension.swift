//
//  ButtonExtension.swift
//  VBTracker
//
//  Created by Vladimir Bozhenov on 20/09/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import UIKit

extension UIButton {
    func setButtonStyle(with color: UIColor) {
        self.layer.cornerRadius = 15 //self.bounds.size.height / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.orange.cgColor
        self.backgroundColor = color
    }
}
