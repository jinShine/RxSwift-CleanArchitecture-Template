//
//  AllUserInteractor.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol UserUseCase {
  func searchUser(since: Int) -> Single<[UserModel]>
}

private class UserUseCaseImpl: UserUseCase {

  private let allUserRepository: UserRepository

  init(allUserRepository: UserRepository) {
    self.allUserRepository = allUserRepository
  }

  func searchUser(since: Int) -> Single<[UserModel]> {
    self.allUserRepository.searchUser(since: since)
  }

}
