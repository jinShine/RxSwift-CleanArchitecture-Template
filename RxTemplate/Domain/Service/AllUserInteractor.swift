//
//  AllUserInteractor.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol AllUserUseCase {
  func allUser(since: Int) -> Single<[UserModel]>
}

final class AllUserInteractor: AllUserUseCase {
  
  func allUser(since: Int) -> Single<[UserModel]> {
    return App.service.buildRequest(to: Router.allUser(since: since))
      .map { response in
        do {
          let result = try JSONDecoder().decode([UserModel].self, from: response.jsonData ?? Data())
          return result
        }
      }
  }
  
}
