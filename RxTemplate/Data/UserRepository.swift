//
//  AllUserRepository.swift
//  RxTemplate
//
//  Created by seungjin on 2019/11/16.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

final class UserRepository {
  
  private let networkService: NetworkService
  
  init(networkService: NetworkService = NetworkService()) {
    self.networkService = networkService
  }
  
}

extension UserRepository: UserUseCase {
  
  func searchUser(since: Int) -> Single<[UserModel]> {
    return networkService.buildRequest(to: Router.searchUser(since: since))
    .map { response in
      do {
        let result = try JSONDecoder().decode([UserModel].self, from: response.jsonData ?? Data())
        return result
      }
    }
  }

}
