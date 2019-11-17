//
//  UserModel+Decodable.swift
//  RxTemplate
//
//  Created by seungjin on 2019/11/18.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

extension UserModel: Decodable {

  enum CodingKeys: String, CodingKey {
      case id
      case name = "login"
      case profile = "avatar_url"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.profile = try container.decode(String.self, forKey: .profile)
  }
}
