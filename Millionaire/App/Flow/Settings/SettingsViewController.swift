//
//  SettingsViewController.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 29.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var questionOrderSegmentedControl: UISegmentedControl!
    
    private var selectedOrder: QuestionsOrder {
        switch self.questionOrderSegmentedControl.selectedSegmentIndex {
        case 0:
            return .straight
        case 1:
            return .shuffle
        default:
            return .straight
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionOrderSegmentedControl.setStyle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        Game.shared.questionsOrder = self.selectedOrder
    }
}
