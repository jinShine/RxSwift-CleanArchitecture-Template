//
//  UserModel.swift
//  RxTemplate
//
//  Created by Seungjin on 26/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionOfUserModel {
  var header: String
  var items: [UserModel]
}

struct UserModel: Decodable {
    var id: Int = 0
    var name: String = ""
    var profile: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "login"
        case profile = "avatar_url"
    }
}

extension SectionOfUserModel: SectionModelType {
  
  init(original: SectionOfUserModel, items: [UserModel]) {
    self = original
    self.items = items
  }

}
