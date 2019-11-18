//
//  Navigator.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

enum Navigator {
  case allUser(AllUserListViewModel)
}

extension Navigator {
  
  var viewController: UIViewController {
    switch self {
    case .allUser:
      let viewModel = AllUserListViewModel(allUserUseCase: UserRepository())
      let viewController = AllUserListViewController(viewModel: viewModel)
      return viewController
    }
  }
}
