//
//  SceneDelegate.swift
//  NowPlayingMovies
//
//  Created by Dara Caroline on 06/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = ViewController()
        window?.makeKeyAndVisible()
        window?.rootViewController = viewController
        window?.windowScene = windowScene
    }

 



}

