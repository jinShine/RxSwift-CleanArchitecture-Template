//
//  UserModel.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxDataSources

struct UserModel {
    var id: Int = 0
    var name: String = ""
    var profile: String = ""
}

struct SectionOfUserModel {
  var header: String
  var items: [UserModel]
}

extension SectionOfUserModel: SectionModelType {
  
  init(original: SectionOfUserModel, items: [UserModel]) {
    self = original
    self.items = items
  }

}
