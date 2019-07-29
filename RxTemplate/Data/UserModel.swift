//
//  UserModel.swift
//  SVmiOS
//
//  Created by 승진김 on 06/03/2019.
//  Copyright © 2019 승진김. All rights reserved.
//

import Foundation

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

