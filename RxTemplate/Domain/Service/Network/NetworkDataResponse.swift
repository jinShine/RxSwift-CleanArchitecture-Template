//
//  NetworkDataResponse.swift
//  RxTemplate
//
//  Created by Seungjin on 25/07/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

enum NetworkResult {
  case success
  case failure
}

struct NetworkDataResponse {
  let jsonData: Data?
  let result: NetworkResult
  var error: NetworkError?
}

enum RequestError: Error {
  case invalidRequest
}
