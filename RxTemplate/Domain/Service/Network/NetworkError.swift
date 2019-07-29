//
//  NetworkError.swift
//  RxTemplate
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

enum NetworkStatusCode: Int {
  case unauthorized = 401
  case forbidden = 403
}

struct NetworkError {
  let title: String
  let description: String
  let error: Error?
}
