//
//  UserRepositoryType.swift
//  RxTemplate
//
//  Created by Seungjin on 18/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol UserRepositoryType {
  func searchUser(since: Int) -> Single<[UserModel]>
}
