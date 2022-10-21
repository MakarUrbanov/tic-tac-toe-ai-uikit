//
//  SceneDelegate.swift
//  tic-tac-toe-ai-uikit
//
//  Created by makar on 10/16/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else {
      return
    }
    window = UIWindow(frame: windowScene.screen.bounds)
    window?.windowScene = windowScene
    let rootNavigationController = MainNavigationController(rootViewController: GameConfigurationViewController())
    //    let rootNavigationController = MainNavigationController(
    //      rootViewController: GameBoardViewController(mode: .ai, side: .cross)
    //    ) // TODO mmk remove
    window?.rootViewController = rootNavigationController
    window?.makeKeyAndVisible()
  }

}
