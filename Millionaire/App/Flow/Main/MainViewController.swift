//
//  MainViewController.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 15.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAppearence()
    }
    
    // MARK: - Methods
    func setViewAppearence() {
        playButton.setButtonStyle(with: .blue)
        resultsButton.setButtonStyle(with: .blue)
    }
    @IBAction func playButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    @IBAction func resultsButtonTapped(_ sender: UIButton) {
    }
}
