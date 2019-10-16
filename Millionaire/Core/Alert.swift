//
//  Alert.swift
//  VBWeather
//
//  Created by Vladimir Bozhenov on 13/07/2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    // MARK: - Methods
    func showAlertWith(title: String,
                       message: String,
                       style: UIAlertController.Style = .alert,
                       in controller: AnyObject) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: style)
        let action = UIAlertAction(title: "ОК",
                                   style: .default) { action in
                                    controller.dismiss(animated: true,
                                                       completion: nil)
        }
        alertController.addAction(action)
        controller.present(alertController,
                           animated: true,
                           completion: nil)
    }
}
