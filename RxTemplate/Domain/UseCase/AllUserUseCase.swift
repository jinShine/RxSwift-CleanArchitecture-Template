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

final class AllUserUseCaseImpl: AllUserUseCase {
  
  private let allUserRepository: AllUserRepository
  
  init(allUserRepository: AllUserRepository) {
    self.allUserRepository = allUserRepository
  }
  
  func allUser(since: Int) -> Single<[UserModel]> {
    allUserRepository.allUser(since: since)
  }
}
