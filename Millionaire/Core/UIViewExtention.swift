//
//  LabelExtention.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 15.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import UIKit

extension UIView {
    func setStyle() {
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.orange.cgColor
        self.backgroundColor = .blue
        self.layer.masksToBounds = true
    }
}
