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
    @IBOutlet weak var settingsButton: UIButton!
    
    // MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewAppearence()
    }
    
    // MARK: - Methods
    private func setViewAppearence() {
        playButton.setStyle()
        resultsButton.setStyle()
        settingsButton.setStyle()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        Game.shared.gameSession = GameSession()
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    @IBAction func resultsButtonTapped(_ sender: UIButton) {
    }
}
