//
//  AppDelegate.swift
//  RxTemplate
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
//    self.window = {
//      let window = UIWindow(frame: UIScreen.main.bounds)
//      window.makeKeyAndVisible()
//      window.backgroundColor = .white
//      window.rootViewController = UINavigationController(rootViewController: Navigator.allUser.viewController)
//      return window
//    }()
    
    if let allUserListVC = window?.rootViewController as? AllUserListViewController {
      allUserListVC.viewModel = AllUserListViewModel(allUserUseCase: AllUserInteractor())
    }
    
    return true
  }

}

