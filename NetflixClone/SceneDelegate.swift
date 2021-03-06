//
//  SceneDelegate.swift
//  NetflixClone
//
//  Created by Roberto Evangelista on 06/03/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let moviesListViewController = MovieCatalogViewController(viewModel: MovieCatalogViewModel())
        let navigationController = UINavigationController(rootViewController: moviesListViewController)
        self.window = window
        self.window?.rootViewController = navigationController
        self.window?.windowScene = scene
        self.window?.makeKeyAndVisible()
    }
    
}

