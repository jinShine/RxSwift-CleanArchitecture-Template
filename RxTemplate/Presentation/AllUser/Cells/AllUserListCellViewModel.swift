//
//  AllUserListCellViewModel.swift
//  RxTemplate
//
//  Created by Seungjin on 29/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

struct AllUserListCellViewModel {
  var id: Int?
  var name: String?
  var profileImage: String?
  
  init(model: UserModel) {
    self.id = model.id
    self.name = model.name
    self.profileImage = model.profile
  }
}
