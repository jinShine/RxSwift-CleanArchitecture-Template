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

    /// DI
    if let allUserListVC = window?.rootViewController as? AllUserListViewController {
      allUserListVC.viewModel = AllUserListViewModel(allUserUseCase: AllUserRepository(networkService: NetworkService()))
    }
    
    return true
  }

}

