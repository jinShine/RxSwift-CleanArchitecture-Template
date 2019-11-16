//
//  AllUserRepository.swift
//  RxTemplate
//
//  Created by seungjin on 2019/11/16.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

final class AllUserRepository {
  
  private let networkService: NetworkService
  
  init(networkService: NetworkService) {
    self.networkService = networkService
  }
  
}

extension AllUserRepository: AllUserUseCase {
  
  func allUser(since: Int) -> Single<[UserModel]> {
    return networkService.buildRequest(to: Router.allUser(since: since))
    .map { response in
      do {
        let result = try JSONDecoder().decode([UserModel].self, from: response.jsonData ?? Data())
        return result
      }
    }
  }

}
