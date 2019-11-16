//
//  SceneDelegate.swift
//  Millionaire
//
//  Created by Vladimir Bozhenov on 14.10.2019.
//  Copyright © 2019 Vladimir Bozhenov. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let sessionCaretaker = SessionCaretaker()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
//        Game.shared.gameSession = sessionCaretaker.retrieveResults()
    }

    func sceneWillResignActive(_ scene: UIScene) {
//        sessionCaretaker.save(session: Game.shared.gameSession ?? GameSession())
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

